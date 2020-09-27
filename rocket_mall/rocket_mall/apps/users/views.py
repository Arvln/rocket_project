from django.contrib.auth import login ,logout
from django.contrib.auth.mixins import LoginRequiredMixin
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from django.db import DatabaseError
from django.http import HttpResponseForbidden ,JsonResponse ,HttpResponseBadRequest ,HttpResponseServerError
import re ,json ,logging
from django.core.paginator import Paginator ,EmptyPage

from users.models import User ,Address
from utils.response_code import RETCODE
from django_redis import get_redis_connection
from users.utils import LoginBackend ,generate_verify_email_url ,check_verify_email_url
from utils.views import LoginRequiredJsonMixin
from . import constants
from celery_tasks.email.tasks import send_verify_mail
from goods.models import SKU
from carts.utils import merge_carts_cookies_redis
from orders.models import OrderInfo

# Create your views here.

#創建日誌輸出器
logger = logging.getLogger('django')

class RegisterView(View):
    """用戶註冊類視圖"""
    def get(self ,request ):
        """提供用戶註冊頁面"""
        return render(request ,'register.html' )

    def post(self ,request ):
        """實現用戶註冊主邏輯"""
        #接收參數
        username = request.POST.get('username')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')
        mobile = request.POST.get('mobile')
        sms_code_client = request.POST.get('sms_code')
        allow = request.POST.get('allow')
        #校驗參數，保障後端安全
        #參數是否齊全
        #參數是否合規
        if not all([username,password,password2,mobile,sms_code_client,allow]):
            return HttpResponseForbidden('缺少必傳參數')
        if not re.match('^[a-zA-Z0-9_-]{5,20}$' ,username ):
            return HttpResponseForbidden('請輸入5~20個字符的用戶名稱')
        count = User.objects.filter(username=username).count()
        if count == 1:
            return HttpResponseForbidden('該用戶名稱已存在')
        if not re.match('^[a-zA-Z0-9_-]{8,12}$', password):
            return HttpResponseForbidden('請輸入8位到12位的密碼')
        if password != password2:
            return HttpResponseForbidden('請檢查與原先輸入的密碼是否相符')
        if not re.match('^09\d{8}$' ,mobile ):
            return HttpResponseForbidden('您輸入的手機號碼格式不正確')
        conn = get_redis_connection('verify_code')
        sms_code_server = conn.get('sms_%s' %mobile )
        if sms_code_server.decode() != sms_code_client:
            return HttpResponseForbidden('請確認簡訊驗證碼是否輸入正確')
        if allow != 'on':
            return HttpResponseForbidden('請勾選同意RockeT使用合約')
        #實現業務邏輯
        try:
            user = User.objects.create_user(username=username ,password=password ,mobile=mobile )
        except DatabaseError:
            return render(request ,'register.html' ,{'register_errmsg':'註冊失敗'})

        #實現狀態保持
        login(request ,user )
        #返回響應:重定向到首頁
        #網頁右上角刷新登入狀態，將用戶登入資訊保存在cookie
        response = redirect(reverse('contents:index'))
        response.set_cookie('username', user.username, constants.LOGIN_COOKIE_EXPIRES)
        return response

class UsercountView(View):

    def get(self ,request ,username ):
        """查詢用戶名數量"""
        #查詢用戶名數
        count = User.objects.filter(username=username).count()
        #返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'count':count })

class MobilecountView(View):

    def get(self ,request ,mobile ):
        """查詢手機號碼數量"""
        #查詢手機號碼數
        count = User.objects.filter(mobile=mobile).count()
        #返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'count':count })

class LoginView(View):
    """用戶登入"""
    def get(self ,request ):
        """提供登入頁面"""
        return render(request ,'login.html' )

    def post(self ,request ):
        """接收登入資料"""
        #接收參數
        username = request.POST.get('username')
        password = request.POST.get('password')
        remembered = request.POST.get('remembered')
        #認證用戶
        res = LoginBackend.authenticate(self ,request ,username=username ,password=password )
        if type(res) == User:
            user = res
        else:
            return res
        # 狀態保持
        login(request ,user )
        # 使用remembered來實現狀態保持週期(記住登入)
        if remembered != 'on':
            #狀態保持在瀏覽器會話結束後銷毀
            request.session.set_expiry(0)
        else:
            # 狀態保持使用默認時限
            request.session.set_expiry(None)
        #返回響應:重定向到next或首頁
        #檢查是否有指定登入後跳轉頁面
        next = request.GET.get('next')
        if next:
            response = redirect(next)
        else:
            response = redirect(reverse('contents:index'))
        #網頁右上角刷新登入狀態，將用戶登入資訊保存在cookie
        response.set_cookie('username' ,user.username ,constants.LOGIN_COOKIE_EXPIRES )

        #用戶登錄成功後，同樣商品將cookies購物車數據覆蓋寫入redis
        response = merge_carts_cookies_redis(request ,user ,response )
        #返回響應
        return response

class CheckusermsgView(View):
    """獲取登入用戶"""
    def get(self ,request ):

        #接收參數
        username = request.GET.get('username')
        password = request.GET.get('password')
        # 認證用戶
        res = LoginBackend.authenticate(self ,request ,username ,password=password )
        # 返回響應
        if type(res) == JsonResponse:
            return res
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK'})

class LogoutView(View):
    """用戶退出登入"""
    def get(self ,request ):

        #用戶退出登入
        logout(request)
        #清除cookie登入信息
        response = redirect(reverse('contents:index'))
        response.delete_cookie('username')
        #返回響應:重定向首頁
        return response

class UserInfoView(LoginRequiredMixin ,View):
    """用戶中心"""
    def get(self ,request ):
        #如果LoginRequiredMixin判斷用戶已登錄，request.user取出用戶模型類對象
        context = {
            'username':request.user.username ,
            'mobile':request.user.mobile ,
            'email':request.user.email ,
            'email_active':request.user.email_active ,
        }

        return render(request ,'user_center_info.html' ,context )

class EmailView(LoginRequiredJsonMixin ,View):
    """更新用戶Email"""
    def put(self ,request ):
        #提取參數
        json_dict = json.loads(request.body)
        email = json_dict.get('email')
        #校驗參數
        if not re.match('^[\w.-]+@[\w-]+(.[\w_-]+)+$' ,email ):
            return HttpResponseForbidden('請確認Email格式是否正確')
        #實現主體業務邏輯:保存Email
        try:
            request.user.email = email
            request.user.save()
        except Exception as e:
            logger.error(e)
            return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'新增Email失敗' })
        #為將保存Email和驗證Email作解耦，採用celery發送驗證Email
        user = request.user
        verify_url = generate_verify_email_url(user)
        send_verify_mail.delay(email ,verify_url )
        #返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' })

class VerifyEmailView(View):
    """驗證用戶Email"""
    def get(self ,request ):

        #提取參數
        token = request.GET.get('token')
        #校驗參數
        if not token:
            return HttpResponseForbidden('缺少必傳參數')
        #提取token中用戶資訊
        user = check_verify_email_url(token)
        if not user:
            return HttpResponseBadRequest('token已失效')
        #驗證用戶Email
        try:
            user.email_active = True
            user.save()
        except Exception as e:
            return HttpResponseServerError('驗證用戶失敗，請再試一次')
        # 返回響應
        return redirect(reverse('users:info'))

class AddressView(LoginRequiredJsonMixin ,View):
    """用戶收貨地址頁面"""
    def get(self ,request ):

        #獲取當前用戶未刪除的地址訊息
        address_model_list = Address.objects.filter(user=request.user ,is_deleted=False )
        #構造響應數據
        address_list = []
        for address in address_model_list:
            address_dict = {
                'id':address.id ,
                'title':address.title ,
                'receiver':address.receiver ,
                'mobile':address.mobile ,
                'email':address.email ,
                'area':address.area.name ,
                'city':address.city.name ,
                'district':address.district.name ,
                'place':address.place ,
            }
            address_list.append(address_dict)
        context = {
            'addresses':address_list ,
            'default_address_id':request.user.default_address_id or '0' , #地址清空後用字串0占位
        }
        #返回響應
        return render(request ,'user_center_site.html' ,context )

class AddressCreateView(LoginRequiredJsonMixin ,View):
    """新增用戶收貨地址"""
    def post(self ,request ):

        #判斷用戶新增地址是否已達上限
        #addresses_count = Address.objects.filter(user=request.user).count()
        addresses_count = request.user.addresses.count()
        if addresses_count > constants.USER_ADDRESS_COUNTS_LIMIT :
            return JsonResponse({'code':RETCODE.THROTTLINGERR ,'errmsg':'新增地址數量已達上限' })
        #提取參數
        json_dict = json.loads(request.body.decode())
        title = json_dict.get('title')
        receiver = json_dict.get('receiver')
        mobile = json_dict.get('mobile')
        email = json_dict.get('email')
        area_id = json_dict.get('area_id')
        city_id = json_dict.get('city_id')
        district_id = json_dict.get('district_id')
        place = json_dict.get('place')
        #校驗參數
        if not all([title ,receiver ,mobile ,area_id ,city_id ,district_id ,place]):
            return HttpResponseForbidden('缺少必傳參數')
        if not re.match('^09[\d]{8}$' ,mobile ):
            return HttpResponseForbidden('您輸入的手機號碼格式不正確')
        if email:
            if not re.match('^[\w.-]+@[\w-]+(.[\w_-]+)+$' ,email ):
                return HttpResponseForbidden('請確認Email格式是否正確')
        #實現主體業務邏輯:新增用戶收貨地址
        try:
            address = Address.objects.create(
                user = request.user ,
                title = title ,
                receiver = receiver ,
                mobile = mobile ,
                email = email ,
                area_id = area_id ,
                city_id = city_id ,
                district_id = district_id ,
                place = place ,
            )
            #用戶初次新增地址，預設當前地址為默認地址
            if request.user.default_address is None:
                request.user.default_address = address
                request.user.save()
        except Exception as e:
            logger.error(e)
            return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'新增用戶地址失敗' })
        #構造響應數據
        address_dict = {
            'id':address.id ,
            'title':address.title ,
            'receiver':address.receiver ,
            'mobile':address.mobile ,
            'email':address.email ,
            'area':address.area.name ,
            'city':address.city.name ,
            'district':address.district.name ,
            'place':address.place ,
        }
        #返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'address':address_dict })

class UpdateDestroyAddressView(LoginRequiredJsonMixin ,View):
    """修改或刪除用戶收貨地址"""
    def put(self ,request ,address_id ):

        #獲取參數
        json_dict = json.loads(request.body.decode())
        title = json_dict.get('title')
        receiver = json_dict.get('receiver')
        mobile = json_dict.get('mobile')
        email = json_dict.get('email')
        area_id = json_dict.get('area_id')
        city_id = json_dict.get('city_id')
        district_id = json_dict.get('district_id')
        place = json_dict.get('place')
        #校驗參數
        if not all([title ,receiver ,mobile ,area_id ,city_id ,district_id ,place]):
            return HttpResponseForbidden('缺少必傳參數')
        if not re.match('^09[\d]{8}$' ,mobile ):
            return HttpResponseForbidden('您輸入的手機號碼格式不正確')
        if email:
            if not re.match('^[\w.-]+@[\w-]+(.[\w_-]+)+$' ,email ):
                return HttpResponseForbidden('請確認Email格式是否正確')
        # 實現主體業務邏輯:修改用戶送貨地址
        try:
            Address.objects.filter(id=address_id).update(
                title=title ,
                receiver=receiver ,
                mobile=mobile ,
                email=email ,
                area_id=area_id ,
                city_id=city_id ,
                district_id=district_id ,
                place=place ,
            )
            address = Address.objects.get(id=address_id)
        except Exception as e:
            logger.error(e)
            return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'修改用戶地址失敗' })
        # 構造響應數據
        address_dict = {
            'id': address.id ,
            'title': address.title ,
            'receiver': address.receiver ,
            'mobile': address.mobile ,
            'email': address.email ,
            'area': address.area.name ,
            'city': address.city.name ,
            'district': address.district.name ,
            'place': address.place ,
        }
        # 返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'address':address_dict })

    def delete(self ,request ,address_id ):

        #實現主體業務邏輯:邏輯刪除
        try:
            Address.objects.filter(id=address_id).update(is_deleted=True)
        except Exception as e:
            logger.error(e)
            return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'刪除用戶地址失敗' })
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'刪除用戶地址成功'})

class DefaultAddressView(LoginRequiredJsonMixin ,View):
    """設置默認地址"""
    def put(self ,request ,address_id ):

        # 實現主體業務邏輯:將用戶默認地址設為當前地址
        try:
            request.user.default_address_id = address_id
            request.user.save()
        except Exception as e:
            logger.error(e)
            return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'修改用戶默認地址失敗' })
        # 返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'修改用戶默認地址成功'})

class UpdateAddressTitleView(LoginRequiredJsonMixin ,View):
    """修改地址標題"""
    def put(self ,request ,address_id ):

        # 提取參數
        json_dict = json.loads(request.body.decode())
        title = json_dict.get('title')
        # 校驗參數
        if not title:
            return HttpResponseForbidden('缺少title')
        # 實現主體業務邏輯:保存用戶取貨地址標題
        try:
            Address.objects.filter(id=address_id).update(title=title)
        except Exception as e:
            logger.error(e)
            return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'修改用戶地址標題失敗' })
        # 返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'修改用戶地址標題成功' })

class UserBrowseHistory(LoginRequiredJsonMixin ,View):
    """用戶瀏覽紀錄"""
    def get(self ,request ):
        """獲取用戶瀏覽紀錄"""

        redis_conn = get_redis_connection('history')
        user = request.user
        #取出用戶瀏覽商品列表
        sku_ids = redis_conn.lrange('history_%s' % user.id ,0 ,-1 )
        #構造響應數據
        skus = []
        for sku_id in sku_ids:
            sku = SKU.objects.get(id=sku_id)
            skus.append({
                'id':sku.id ,
                'name':sku.name ,
                'price':sku.price ,
                'comments':sku.comments ,
                'default_image_url':sku.default_image_url ,
            })
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'skus':skus })

    def post(self ,request ):
        """保存用戶瀏覽紀錄"""

        #接收參數
        sku_id = json.loads(request.body.decode()).get('sku_id')
        #校驗參數
        try:
            SKU.objects.get(id=sku_id)
        except Exception:
            return HttpResponseForbidden('該商品不存在')
        #保存瀏覽商品紀錄:存到redis三號庫，以list存儲
        redis_conn = get_redis_connection('history')
        pl = redis_conn.pipeline()
        #先去重
        user = request.user
        pl.lrem('history_%s' % user.id ,0 ,sku_id )
        #再保存
        pl.lpush('history_%s' % user.id ,sku_id )
        #再擷取
        pl.ltrim('history_%s' % user.id ,0 ,4 )
        pl.execute()
        #返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' })

class UserOrderInfoView(LoginRequiredMixin ,View):
    """返回用戶訂單頁面"""
    def get(self ,request ,page_num ):

        #查詢所有訂單
        orders = OrderInfo.objects.filter(user=request.user).order_by('create_time')
        #獲取訂單數據
        user_orders = []
        for order in orders:
            skus = []
            for order_good in order.skus.all():
                sku = order_good.sku
                sku_dict = {
                    'id':sku.id ,
                    'name':sku.name ,
                    'price':sku.price ,
                    'count':order_good.count ,
                    'amount':sku.price * order_good.count ,
                    'default_image_url':sku.default_image_url ,
                }
                skus.append(sku_dict)
            user_order = {
                'update_time': order.update_time ,
                'order_id': order.order_id ,
                'skus': skus ,
                'freight': order.freight ,
                'total_amount': order.total_amount ,
                'pay_method': OrderInfo.PAY_METHOD_CHOICES[order.pay_method - 1][1],
                'status': OrderInfo.ORDER_STATUS_CHOICES[order.status - 1][1] ,
            }
            user_orders.append(user_order)
        #訂單分頁
        paginator = Paginator(user_orders, 2)
        #當前頁面的訂單
        try:
            page_orders = paginator.page(page_num)
        except EmptyPage:
            return HttpResponseForbidden('頁面不存在')
        #總頁數
        total_page = paginator.num_pages
        #構造響應數據
        context = {
            'page_orders':page_orders ,
            'page_num':page_num ,
            'total_page':total_page ,
        }
        return render(request, 'user_center_order.html' ,context)

class ChangePasswordView(LoginRequiredMixin ,View ):

    def get(self ,request ):
        """提供修改密碼頁面"""
        return render(request ,'user_center_password.html' )

    def post(self ,request ):
        """修改密碼"""

        #提取參數
        user = request.user
        old_pwd = request.POST.get('old_pwd')
        new_pwd = request.POST.get('new_pwd')
        new_pwd2 = request.POST.get('new_pwd2')
        #校驗參數
        if not all([old_pwd ,new_pwd ,new_pwd2 ]):
            return HttpResponseForbidden('缺少必傳參數')
        if not re.match('^[a-zA-Z0-9_-]{8,12}$', old_pwd):
            return HttpResponseForbidden('請輸入8位到12位的密碼')
        if not request.user.check_password(old_pwd):
            return render(request ,'user_center_password.html' ,{'password_errmsg':'密碼錯誤'})
        if not re.match('^[a-zA-Z0-9_-]{8,12}$', new_pwd):
            return HttpResponseForbidden('請輸入8位到12位的新密碼')
        if old_pwd == new_pwd:
            return render(request ,'user_center_password.html' ,{'password_errmsg':'新密碼不能和原密碼相同'})
        if new_pwd != new_pwd2:
            return HttpResponseForbidden('檢查與原先輸入的新密碼是否相符')
        #修改密碼
        try:
            user.set_password(new_pwd)
            user.save()
        except Exception as e:
            logger.error(e)
            return render(request ,'user_center_password.html' ,{'password_errmsg':'修改密碼失敗'})
        #登出用戶
        logout(request)
        response = redirect('users:login')
        response.delete_cookie('username')
        return response