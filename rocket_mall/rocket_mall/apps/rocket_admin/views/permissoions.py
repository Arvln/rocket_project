from rest_framework.viewsets import ModelViewSet
from django.contrib.auth.models import Permission ,ContentType
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

from rocket_admin.serializers.permissions import PermissionSerializer ,ContentTypeSerializer
from rocket_admin.utils import PageNum


class PermissionView(ModelViewSet):
    """權限管理"""
    permission_classes = [IsAdminUser]
    queryset = Permission.objects.all()
    serializer_class = PermissionSerializer
    pagination_class = PageNum

    def content_type(self, request):
        """
        獲取權限類型
        """
        data = ContentType.objects.all()
        ser = ContentTypeSerializer(data, many=True)
        return Response(ser.data)