from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAdminUser
from django.contrib.auth.models import Group ,Permission
from rest_framework.response import Response

from rocket_admin.serializers.group import GroupSerializer
from rocket_admin.utils import PageNum
from rocket_admin.serializers.permissions import PermissionSerializer

class GroupView(ModelViewSet):
    """用戶組管理"""
    permission_classes = [IsAdminUser]
    queryset = Group.objects.all()
    serializer_class = GroupSerializer
    pagination_class = PageNum

    def simple(self, request):
        """獲取權限數據"""
        data = Permission.objects.all()
        ser = PermissionSerializer(data, many=True)
        return Response(ser.data)