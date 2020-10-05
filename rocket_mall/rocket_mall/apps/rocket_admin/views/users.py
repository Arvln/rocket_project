from rest_framework.generics import ListAPIView ,CreateAPIView ,ListCreateAPIView

from users.models import User
from rocket_admin.serializers.users import UserSerializer
from rocket_admin.utils import PageNum

class UserView(ListCreateAPIView):
    """
    獲取用戶數據
    :params:page,pagesite
    :return:user(s)
    """
    #指定查詢集
    # queryset =
    #建立序列化器
    serializer_class = UserSerializer
    #指定分頁器
    pagination_class = PageNum
    #重寫指定查詢集數據的方法
    def get_queryset(self):
        if self.request.query_params.get('username') is None:
            return User.objects.all()
        else:
            # 模糊查詢
            return User.objects.filter(username__contains=self.request.query_params.get('username'))
