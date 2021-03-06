from rest_framework import serializers
from django.contrib.auth.models import Permission ,ContentType


class PermissionSerializer(serializers.ModelSerializer):
    """權限序列化器"""
    class Meta:
        model = Permission
        fields = '__all__'

class ContentTypeSerializer(serializers.ModelSerializer):
    """權限類型序列化器"""
    name = serializers.CharField(read_only=True)
    class Meta:
        model = ContentType
        fields = '__all__'