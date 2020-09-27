from django.shortcuts import render
from django.http import HttpResponseForbidden ,HttpResponseNotFound ,JsonResponse ,HttpResponseServerError
from django.views import View
from django.core.paginator import Paginator ,EmptyPage
from django.middleware.csrf import get_token
from django.utils import timezone
from datetime import datetime

from goods.models import GoodsCategory ,SKU ,SKUSpecification ,GoodsVisitCount
from contents.utils import get_categories
from goods.utils import get_breadcrumb
from utils.response_code import RETCODE
# Create your views here.


class ListView(View):
    """查詢商品分類數據接口"""

    #需求:為提高SEO效率，首頁採用jinja2做SSR
    def get(self, request, category_id, page_num):
        #校驗category_id
        try:
            category = GoodsCategory.objects.get(id=category_id)
        except Exception:
            return HttpResponseForbidden('商品類別不存在')
        #獲取商品分類
        categories = get_categories()
        #查詢麵包屑導航
        breadcrumb = get_breadcrumb(category)
        #分頁和排序查詢
        #獲取並判斷排序規則
        sort = request.GET.get('sort', 'default')
        if sort == 'price':
            sort_field = 'price'
        elif sort == 'hot':
            sort_field = '-sales'
        else:
            sort = 'default'
            sort_field = 'create_time'
        skus = category.sku_set.filter(is_launched=True).order_by(sort_field)
        #獲取當前分頁的商品數據
        paginator = Paginator(skus, 5)
        try:
            page_skus = paginator.page(page_num)
        except EmptyPage:
            return HttpResponseNotFound('頁面不存在')
        #獲取總頁數
        total_page = paginator.num_pages
        #構造響應數據
        context = {
            'categories': categories,
            'breadcrumb': breadcrumb,
            'page_skus': page_skus,
            'total_page': total_page,
            'page_num': page_num,
            'sort': sort,
            'category_id': category_id,
        }

        return render(request, 'list.html', context)

class HotGoodsView(View):
    """暢銷商品"""
    def get(self, request, category_id):

        #校驗參數
        #查詢當前類別銷量最高的前兩個上架商品
        try:
            skus = SKU.objects.filter(category_id=category_id, is_launched=True).order_by('-sales')[:2]
        except Exception:
            return HttpResponseForbidden('商品類別不存在')
        #網頁訪問不須登入，所以設置csrftoken
        token = get_token(request)
        #構造響應數據
        hot_skus = []
        for sku in skus:
            hot_skus.append({
                'id': sku.id,
                'default_image_url': sku.default_image_url,
                'name': sku.name,
                'price': sku.price,
                'comments': sku.comments,
            })
        return JsonResponse({'code': RETCODE.OK, 'errmsg': 'OK', 'hot_skus': hot_skus})

class DetailView(View):
    """商品詳情頁"""

    def get(self, request ,sku_id ):
        """提供商品詳情頁面"""

        #接收並校驗參數
        try:
            sku = SKU.objects.get(id=sku_id, is_launched=True)
        except Exception:
            return render(request, '404.html')
        #查詢商品分類
        categories = get_categories()
        #查詢麵包屑導航
        breadcrumb = get_breadcrumb(sku.category)
        #查詢當前商品規格
        goods = sku.goods
        #建立當前商品規格鍵
        sku_specs = sku.skuspecification_set.order_by('spec_id')
        sku_key = []  # [規格1,規格2,..]
        for spec in sku_specs:
            sku_key.append(spec.option_id)
        #取出當前商品所有規格鍵和對應sku_id建立字典
        skus = sku.goods.sku_set.all()
        key_sku_map = {}
        for s in skus:
            s_specs = s.skuspecification_set.order_by('spec_id')
            key = []
            for spec in s_specs:
                key.append(spec.option_id)
            key_sku_map[tuple(key)] = s.id  # {(規格1,規格2,..):sku_id,..)
        #獲取當前商品規格對象
        goods_specs = goods.goodsspecification_set.order_by('id')
        for index, spec in enumerate(goods_specs):
            #複製當前規格鍵
            key = sku_key[:]
            options = spec.specificationoption_set.all()
            for option in options:
                #查出當前商品對應的規格對象
                key[index] = option.id
                #從字典找出sku_id賦值
                option.sku_id = key_sku_map.get(tuple(key))
            spec.spec_options = options

        #構造響應數據
        context = {
            'categories':categories ,
            'breadcrumb':breadcrumb ,
            'sku':sku ,
            'specs':goods_specs ,
            'category_id':sku.category.id ,
        }
        return render(request ,'detail.html' ,context )

class DetailVisitView(View):
    """統計分類商品訪問量"""
    def post(self ,request ,category_id ):

        #接收並校驗參數
        try:
            category = GoodsCategory.objects.get(id=category_id)
        except Exception:
            return HttpResponseForbidden('商品類別不存在')
        #獲取當天日期
        t = timezone.localtime()
        today_str = '%d-%02d-%02d' % (t.year ,t.month ,t.day)
        today_date = datetime.strptime(today_str ,'%Y-%m-%d' ) #時間字符串轉時間對象
        #判斷當天商品紀錄是否存在
        try:
            visit_count = GoodsVisitCount.objects.get(date=today_date ,category_id=category_id)
        except:
            GoodsVisitCount.objects.create(category_id=category_id ,count=1 )
        else:
            try:
                visit_count.count+=1
                visit_count.save()
            except Exception as e:
                return HttpResponseServerError('統計失敗')
        #響應結果
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' })