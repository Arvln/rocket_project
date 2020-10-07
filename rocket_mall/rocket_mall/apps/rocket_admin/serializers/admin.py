from rest_framework import serializers

from users.models import User


class AdminSerializer(serializers.ModelSerializer):
    """管理員序列化器"""
    class Meta:
        model = User
        fields = '__all__'
        #給字段增加額外參數
        extra_kwargs = {
            'password':{
                'write_only':True
            }
        }

    def create(self, validated_data):
        """給用戶管理員權限和密碼加密"""
        user = User.objects.create_user(is_staff=True, **validated_data)
        return user

    def update(self, instance, validated_data):
        """更新後做密碼加密"""
        user = super().update(instance, validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user