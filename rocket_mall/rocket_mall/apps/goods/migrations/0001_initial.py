# Generated by Django 3.1.1 on 2020-09-14 03:34

import ckeditor.fields
import ckeditor_uploader.fields
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Brand',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('name', models.CharField(max_length=20, verbose_name='名稱')),
                ('logo', models.ImageField(upload_to='', verbose_name='Logo圖片')),
                ('first_letter', models.CharField(max_length=1, verbose_name='品牌首字母')),
            ],
            options={
                'verbose_name': '品牌',
                'verbose_name_plural': '品牌',
                'db_table': 'tb_brand',
            },
        ),
        migrations.CreateModel(
            name='Goods',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('name', models.CharField(max_length=50, verbose_name='名稱')),
                ('sales', models.IntegerField(default=0, verbose_name='銷量')),
                ('comments', models.IntegerField(default=0, verbose_name='評價數')),
                ('desc_detail', ckeditor.fields.RichTextField(default='', verbose_name='詳細介紹')),
                ('desc_pack', ckeditor.fields.RichTextField(default='', verbose_name='包裝訊息')),
                ('desc_service', ckeditor_uploader.fields.RichTextUploadingField(default='', verbose_name='售后服務')),
                ('brand', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='goods.brand', verbose_name='品牌')),
            ],
            options={
                'verbose_name': '商品',
                'verbose_name_plural': '商品',
                'db_table': 'tb_goods',
            },
        ),
        migrations.CreateModel(
            name='GoodsCategory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('name', models.CharField(max_length=10, verbose_name='名稱')),
                ('parent', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='subs', to='goods.goodscategory', verbose_name='父類别')),
            ],
            options={
                'verbose_name': '商品類别',
                'verbose_name_plural': '商品類别',
                'db_table': 'tb_goods_category',
            },
        ),
        migrations.CreateModel(
            name='GoodsChannelGroup',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('name', models.CharField(max_length=20, verbose_name='頻道組名')),
            ],
            options={
                'verbose_name': '商品類別',
                'verbose_name_plural': '商品類別',
                'db_table': 'tb_channel_group',
            },
        ),
        migrations.CreateModel(
            name='GoodsSpecification',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('name', models.CharField(max_length=20, verbose_name='規格名稱')),
                ('goods', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='goods.goods', verbose_name='商品')),
            ],
            options={
                'verbose_name': '商品規格',
                'verbose_name_plural': '商品規格',
                'db_table': 'tb_goods_specification',
            },
        ),
        migrations.CreateModel(
            name='SKU',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('name', models.CharField(max_length=50, verbose_name='名稱')),
                ('caption', models.CharField(max_length=100, verbose_name='副標題')),
                ('price', models.DecimalField(decimal_places=2, max_digits=10, verbose_name='單價')),
                ('cost_price', models.DecimalField(decimal_places=2, max_digits=10, verbose_name='進價')),
                ('market_price', models.DecimalField(decimal_places=2, max_digits=10, verbose_name='市場價')),
                ('stock', models.IntegerField(default=0, verbose_name='庫存')),
                ('sales', models.IntegerField(default=0, verbose_name='銷量')),
                ('comments', models.IntegerField(default=0, verbose_name='評價數')),
                ('is_launched', models.BooleanField(default=True, verbose_name='是否上架銷售')),
                ('default_image_url', models.CharField(blank=True, default='', max_length=200, null=True, verbose_name='默認圖片')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='goods.goodscategory', verbose_name='從屬類别')),
                ('goods', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='goods.goods', verbose_name='商品')),
            ],
            options={
                'verbose_name': '商品SKU',
                'verbose_name_plural': '商品SKU',
                'db_table': 'tb_sku',
            },
        ),
        migrations.CreateModel(
            name='SpecificationOption',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('value', models.CharField(max_length=20, verbose_name='選項值')),
                ('spec', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='goods.goodsspecification', verbose_name='規格')),
            ],
            options={
                'verbose_name': '規格選項',
                'verbose_name_plural': '規格選項',
                'db_table': 'tb_specification_option',
            },
        ),
        migrations.CreateModel(
            name='SKUSpecification',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('option', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='goods.specificationoption', verbose_name='規格值')),
                ('sku', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='goods.sku', verbose_name='sku')),
                ('spec', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='goods.goodsspecification', verbose_name='規格名稱')),
            ],
            options={
                'verbose_name': 'SKU規格',
                'verbose_name_plural': 'SKU規格',
                'db_table': 'tb_sku_specification',
            },
        ),
        migrations.CreateModel(
            name='SKUImage',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('image', models.ImageField(upload_to='', verbose_name='圖片')),
                ('sku', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='goods.sku', verbose_name='sku')),
            ],
            options={
                'verbose_name': 'SKU圖片',
                'verbose_name_plural': 'SKU圖片',
                'db_table': 'tb_sku_image',
            },
        ),
        migrations.CreateModel(
            name='GoodsChannel',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='創建時間')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='更新時間')),
                ('group_id', models.IntegerField(verbose_name='組號')),
                ('url', models.CharField(max_length=50, verbose_name='頻道頁面鏈接')),
                ('sequence', models.IntegerField(verbose_name='組內順序')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='goods.goodscategory', verbose_name='頂級商品類别')),
            ],
            options={
                'verbose_name': '商品頻道',
                'verbose_name_plural': '商品頻道',
                'db_table': 'tb_goods_channel',
            },
        ),
        migrations.AddField(
            model_name='goods',
            name='category1',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='cat1_goods', to='goods.goodscategory', verbose_name='一級類别'),
        ),
        migrations.AddField(
            model_name='goods',
            name='category2',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='cat2_goods', to='goods.goodscategory', verbose_name='二級類别'),
        ),
        migrations.AddField(
            model_name='goods',
            name='category3',
            field=models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='cat3_goods', to='goods.goodscategory', verbose_name='三級類别'),
        ),
    ]