from django.db import models

from utils.models import BaseModel
from ckeditor.fields import RichTextField
from ckeditor_uploader.fields import RichTextUploadingField

# Create your models here.


class GoodsCategory(BaseModel):
    """商品類别"""
    name = models.CharField(max_length=10, verbose_name='名稱')
    parent = models.ForeignKey('self',related_name='subs' ,null=True, blank=True, on_delete=models.CASCADE, verbose_name='父類别')

    class Meta:
        db_table = 'tb_goods_category'
        verbose_name = '商品類别'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class GoodsChannelGroup(BaseModel):
    """商品頻道組"""
    name = models.CharField(max_length=20 ,verbose_name='頻道組名' )

    class Meta:
        db_table = 'tb_channel_group'
        verbose_name = '商品類別'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class GoodsChannel(BaseModel):
    """商品頻道"""
    group_id = models.IntegerField(verbose_name='組號')
    category = models.ForeignKey(GoodsCategory, on_delete=models.CASCADE, verbose_name='頂級商品類别')
    url = models.CharField(max_length=50, verbose_name='頻道頁面鏈接')
    sequence = models.IntegerField(verbose_name='組內順序')

    class Meta:
        db_table = 'tb_goods_channel'
        verbose_name = '商品頻道'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.category.name

class Brand(BaseModel):
    """品牌"""
    name = models.CharField(max_length=20, verbose_name='名稱')
    logo = models.ImageField(null=True ,blank=True , verbose_name='Logo圖片')
    first_letter = models.CharField(max_length=1, verbose_name='品牌首字母')

    class Meta:
        db_table = 'tb_brand'
        verbose_name = '品牌'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class Goods(BaseModel):
    """商品SPU"""
    name = models.CharField(max_length=50, verbose_name='名稱')
    brand = models.ForeignKey(Brand, on_delete=models.PROTECT, verbose_name='品牌')
    category1 = models.ForeignKey(GoodsCategory, on_delete=models.PROTECT, related_name='cat1_goods', verbose_name='一級類别')
    category2 = models.ForeignKey(GoodsCategory, on_delete=models.PROTECT, related_name='cat2_goods', verbose_name='二級類别')
    category3 = models.ForeignKey(GoodsCategory, on_delete=models.PROTECT, related_name='cat3_goods', verbose_name='三級類别')
    sales = models.IntegerField(default=0, verbose_name='銷量')
    comments = models.IntegerField(default=0, verbose_name='評價數')
    desc_detail = RichTextField(default='', verbose_name='詳細介紹')
    desc_pack = RichTextField(default='', verbose_name='包裝訊息')
    desc_service = RichTextUploadingField(default='', verbose_name='售后服務')

    class Meta:
        db_table = 'tb_goods'
        verbose_name = '商品'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class GoodsSpecification(BaseModel):
    """商品規格"""
    goods = models.ForeignKey(Goods, on_delete=models.CASCADE, verbose_name='商品')
    name = models.CharField(max_length=20, verbose_name='規格名稱')

    class Meta:
        db_table = 'tb_goods_specification'
        verbose_name = '商品規格'
        verbose_name_plural = verbose_name

    def __str__(self):
        return '%s: %s' % (self.goods.name, self.name)

class SpecificationOption(BaseModel):
    """規格選項"""
    spec = models.ForeignKey(GoodsSpecification, on_delete=models.CASCADE, verbose_name='規格')
    value = models.CharField(max_length=20, verbose_name='選項值')

    class Meta:
        db_table = 'tb_specification_option'
        verbose_name = '規格選項'
        verbose_name_plural = verbose_name

    def __str__(self):
        return '%s - %s' % (self.spec, self.value)

class SKU(BaseModel):
    """商品SKU"""
    name = models.CharField(max_length=300, verbose_name='名稱')
    caption = models.CharField(max_length=100, verbose_name='副標題')
    goods = models.ForeignKey(Goods, on_delete=models.CASCADE, verbose_name='商品')
    category = models.ForeignKey(GoodsCategory, on_delete=models.PROTECT, verbose_name='從屬類别')
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='單價')
    cost_price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='進價')
    market_price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name='市場價')
    stock = models.IntegerField(default=0, verbose_name='庫存')
    sales = models.IntegerField(default=0, verbose_name='銷量')
    comments = models.IntegerField(default=0, verbose_name='評價數')
    is_launched = models.BooleanField(default=True, verbose_name='是否上架銷售')
    default_image_url = models.CharField(max_length=200, default='', null=True, blank=True, verbose_name='默認圖片')

    class Meta:
        db_table = 'tb_sku'
        verbose_name = '商品SKU'
        verbose_name_plural = verbose_name

    def __str__(self):
        return '%s: %s' % (self.id, self.name)

class SKUImage(BaseModel):
    """SKU圖片"""
    sku = models.ForeignKey(SKU, on_delete=models.CASCADE, verbose_name='sku')
    image = models.ImageField(verbose_name='圖片')

    class Meta:
        db_table = 'tb_sku_image'
        verbose_name = 'SKU圖片'
        verbose_name_plural = verbose_name

    def __str__(self):
        return '%s %s' % (self.sku.name, self.id)

class SKUSpecification(BaseModel):
    """SKU具體規格"""
    sku = models.ForeignKey(SKU, on_delete=models.CASCADE, verbose_name='sku')
    spec = models.ForeignKey(GoodsSpecification, on_delete=models.PROTECT, verbose_name='規格名稱')
    option = models.ForeignKey(SpecificationOption, on_delete=models.PROTECT, verbose_name='規格值')

    class Meta:
        db_table = 'tb_sku_specification'
        verbose_name = 'SKU規格'
        verbose_name_plural = verbose_name

    def __str__(self):
        return '%s: %s - %s' % (self.sku, self.spec.name, self.option.value)

class GoodsVisitCount(BaseModel):
    """統計分類商品訪問量"""
    category = models.ForeignKey(GoodsCategory ,on_delete=models.CASCADE ,verbose_name='商品分類' )
    count = models.IntegerField(verbose_name='訪問量' ,default=0 )
    date = models.DateField(auto_now_add=True ,verbose_name='統計日期' )

    class Meta:
        db_table = 'tb_goods_visit'
        verbose_name = '統計分類商品訪問量'
        verbose_name_plural = verbose_name