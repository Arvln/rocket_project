from django.conf.urls import url
from rest_framework_jwt.views import obtain_jwt_token
from .views import statistical ,users

urlpatterns = [
    #後臺登錄
    url(r'^api/authorizations/$', obtain_jwt_token),

    #用戶總量統計
    url(r'^api/statistical/total_count/$' ,statistical.UserCountView.as_view()),
    #日增用戶數量統計
    url(r'^api/statistical/daily_increment/$' ,statistical.UserDailyGrouthView.as_view()),
    #日活用戶數量統計
    url(r'^api/statistical/daily_active/$' ,statistical.UserDailyActiveView.as_view()),
    #當天下單用戶數量統計
    url(r'^api/statistical/daily_order/$' ,statistical.UserDailyOrderCountView.as_view()),
    #月增用戶數量統計
    url(r'^api/statistical/month_increment/$' ,statistical.UserMonthGrouthView.as_view()),
    #月活用戶數量統計
    url(r'^api/statistical/month_active/$' ,statistical.UserMonthActiveView.as_view()),
    #當天訪問分類資訊的訪問量
    url(r'^api/statistical/categories/daily_views/$' ,statistical.CategoriesDailyVisitView.as_view()),

    #獲取用戶數據
    url(r'^api/users/(?P<username>[a-zA-Z0-9_-]{1,20})||None/$' ,users.UserView.as_view()),
]