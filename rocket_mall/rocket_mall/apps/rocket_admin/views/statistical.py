from rest_framework.views import APIView
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from datetime import date ,timedelta

from users.models import User
from goods.models import GoodsVisitCount
from rocket_admin.serializers.statistical import CategoriesDailyVisitSerializer

#查詢數據功能，視圖集是處理複雜功能、擴展類是返回數據對象所以都不考慮，選擇使用APIView

class UserCountView(APIView):
    """用戶總量統計"""
    #權限指定
    permission_classes = [IsAdminUser]
    def get(self ,request ):
        #獲取當天日期
        now_date = date.today()
        #獲取用戶總量
        count = User.objects.all().count()
        #返回響應
        return Response({
            'date':now_date ,
            'count':count ,
        })

class UserDailyGrouthView(APIView):
    """日增用戶數量統計"""
    #權限指定
    permission_classes = [IsAdminUser]
    def get(self ,request ):

        now_date = date.today()
        count = User.objects.filter(date_joined__gte=now_date).count()
        return Response({
            'date':now_date ,
            'count':count ,
        })

class UserDailyActiveView(APIView):
    """日活用戶數量統計"""
    #權限指定
    permission_classes = [IsAdminUser]
    def get(self ,request ):

        now_date = date.today()
        count = User.objects.filter(last_login__gte=now_date).count()
        return Response({
            'date':now_date ,
            'count':count ,
        })

class UserDailyOrderCountView(APIView):
    """當天下單用戶數量統計"""
    #權限指定
    permission_classes = [IsAdminUser]
    def get(self ,request ):

        now_date = date.today()
        count = User.objects.filter(orderinfo__create_time__gte=now_date).count()
        return Response({
            'date':now_date ,
            'count':count ,
        })

class UserMonthGrouthView(APIView):
    """月增用戶數量統計"""
    #權限指定
    permission_classes = [IsAdminUser]
    def get(self ,request ):
        now_date = date.today()
        first_date = now_date - timedelta(days=29)
        date_list = []
        for i in range(30):
            begin_date = first_date + timedelta(days=i)
            next_date = begin_date + timedelta(days=1)
            count = User.objects.filter(date_joined__gte=begin_date, date_joined__lte=next_date).count()
            date_dict = {
                'date':begin_date ,
                'count':count ,
            }
            date_list.append(date_dict)
        return Response(date_list)

class UserMonthActiveView(APIView):
    """月活用戶數量統計"""
    #權限指定
    permission_classes = [IsAdminUser]
    def get(self ,request ):

        now_date = date.today()
        first_date = now_date - timedelta(days=29)
        date_list = []
        for i in range(30):
            #當月某天日期
            begin_date = first_date + timedelta(days=i)
            #隔天日期
            next_date = begin_date + timedelta(days=i+1)
            #當月某天登入人數總量
            count = User.objects.filter(last_login__gte=begin_date, last_login__lte=next_date).count()
            date_dict = {
                'date':begin_date ,
                'count':count ,
            }
            date_list.append(date_dict)
        return Response(date_list)

class CategoriesDailyVisitView(APIView):
    """當天訪問分類資訊的訪問量"""
    #權限指定
    permission_classes = [IsAdminUser]
    def get(self ,request ):

        now_date = date.today()
        goods = GoodsVisitCount.objects.filter(date=now_date)
        ser = CategoriesDailyVisitSerializer(goods, many=True)
        return Response(ser.data)