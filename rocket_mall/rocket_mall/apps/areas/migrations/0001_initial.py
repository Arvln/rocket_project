# Generated by Django 3.1.1 on 2020-09-11 08:28

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Area',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20, verbose_name='名稱')),
                ('parent', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='subs', to='areas.area', verbose_name='上級行政區')),
            ],
            options={
                'verbose_name': '行政區',
                'verbose_name_plural': '行政區',
                'db_table': 'tb_areas',
            },
        ),
    ]
