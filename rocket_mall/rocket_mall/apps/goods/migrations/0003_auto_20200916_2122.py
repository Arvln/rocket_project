# Generated by Django 3.1.1 on 2020-09-16 13:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('goods', '0002_auto_20200915_1710'),
    ]

    operations = [
        migrations.AlterField(
            model_name='sku',
            name='name',
            field=models.CharField(max_length=300, verbose_name='名稱'),
        ),
    ]
