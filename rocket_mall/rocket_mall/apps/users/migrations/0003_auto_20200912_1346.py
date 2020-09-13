# Generated by Django 3.1.1 on 2020-09-12 05:46

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('areas', '0001_initial'),
        ('users', '0002_user_email_active'),
    ]

    operations = [
        migrations.CreateModel(
            name='Address',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('title', models.CharField(max_length=20, verbose_name='地址名稱')),
                ('receiver', models.CharField(max_length=20, verbose_name='收貨人')),
                ('mobile', models.CharField(max_length=10, verbose_name='手機')),
                ('email', models.CharField(blank=True, default='', max_length=30, null=True, verbose_name='電子信箱')),
                ('place', models.CharField(max_length=50, verbose_name='地址')),
                ('is_deleted', models.BooleanField(default=False, verbose_name='邏輯刪除')),
                ('area', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='area_addresses', to='areas.area', verbose_name='區域')),
                ('city', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='city_addresses', to='areas.area', verbose_name='縣市')),
                ('district', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='district_addresses', to='areas.area', verbose_name='郵遞區號')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='addresses', to=settings.AUTH_USER_MODEL, verbose_name='用戶')),
            ],
            options={
                'verbose_name': '用戶地址',
                'verbose_name_plural': '用戶地址',
                'db_table': 'tb_address',
                'ordering': ['-update_time'],
            },
        ),
        migrations.AddField(
            model_name='user',
            name='default_address',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='users', to='users.address', verbose_name='默認地址'),
        ),
    ]