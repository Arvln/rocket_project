from django.conf.urls import url
from rest_framework_jwt.views import obtain_jwt_token
from rest_framework.routers import DefaultRouter
from .views import statistical ,users ,specs ,images ,skus ,orders

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
    url(r'^api/users/$' ,users.UserView.as_view()),
    #獲取SPU規格表數據
    url(r'^api/goods/simple/$' ,specs.SpecView.as_view({'get':'simple'})),
    #獲取SKU規格表數據
    url(r'^api/skus/simple/$', images.ImageView.as_view({'get':'simple'})),
    #獲取SPU商品規格資訊
    url(r'^api/goods/(?P<pk>\d+)/specs/$', skus.SKUView.as_view({'get':'specs'}))
]

#ViewSet自動生成路由
#SPU規格表
router = DefaultRouter()
router.register('api/goods/specs', specs.SpecView, basename='specs')
urlpatterns += router.urls

#圖片表
router = DefaultRouter()
router.register('api/skus/images', images.ImageView, basename='images')
urlpatterns += router.urls

#SKU表
router = DefaultRouter()
router.register('api/skus', skus.SKUView, basename='skus')
urlpatterns += router.urls

#Order
router = DefaultRouter()
router.register('api/orders', orders.OrderView, basename='orders')
print(router.urls)
urlpatterns += router.urls