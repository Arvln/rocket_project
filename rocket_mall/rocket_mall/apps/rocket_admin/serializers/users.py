from rest_framework import serializers
import re

from users.models import User

class UserSerializer(serializers.ModelSerializer):
    """用戶序列化器"""
    #確認涵蓋所有業務邏輯(get/post/put/delete)字段
    class Meta:
        model = User
        fields = ('id' ,'username' ,'mobile' ,'email' ,'password')
        extra_kwargs = {
            'password':{
                'write_only':True ,
                'max_length':12 ,
                'min_length':8 ,
            },
            'username':{
                'max_length':20 ,
                'min_length':5 ,
            },
        }
    def validate_mobile(self, value):
        if not re.match(r'^09\d{8}' ,value):
            raise serializers.ValidationError('請確認手機號碼格式是否正確')
        return value
    def validate_email(self ,value):
        if value:
            if not re.match(r'^[\w.-]+@[\w-]+(.[\w_-]+)+$' ,value):
                raise serializers.ValidationError('請確認Email格式是否正確')
        return value
    #重寫新增用戶方法為密碼加密
    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user