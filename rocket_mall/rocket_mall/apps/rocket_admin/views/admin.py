from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAdminUser
from django.contrib.auth.models import Group
from rest_framework.response import Response

from users.models import User
from rocket_admin.utils import PageNum
from rocket_admin.serializers.admin import AdminSerializer
from rocket_admin.serializers.group import GroupSerializer


class AdminView(ModelViewSet):
    """管理員管理"""
    permission_classes = [IsAdminUser]
    queryset = User.objects.filter(is_staff=True)
    serializer_class = AdminSerializer
    pagination_class = PageNum

    def simple(self, request):
        """獲取分組資訊"""
        data = Group.objects.all()
        ser = GroupSerializer(data, many=True)
        return Response(ser.data)