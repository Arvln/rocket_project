#!/usr/bin/env python

import sys
sys.path.insert(0, '../')

import os
if not os.getenv('DJANGO_SETTINGS_MODULE'):
    os.environ['DJANGO_SETTINGS_MODULE'] = 'rocket_mall.settings.dev'

import django
django.setup()

from django.template import loader
import settings

from goods.models import SKU
from contents.utils import get_categories
from goods.utils import get_breadcrumb


def generate_static_sku_detail_html(sku_id):
    """批量生成商品詳情頁靜態頁面"""
    #獲取SKU
    sku = SKU.objects.get(id=sku_id, is_launched=True)
    #查詢商品分類
    categories = get_categories()
    #查詢麵包屑導航
    breadcrumb = get_breadcrumb(sku.category)
    #查詢當前商品規格
    goods = sku.goods
    #建立當前商品規格鍵
    sku_specs = sku.skuspecification_set.order_by('spec_id')
    sku_key = []  #[規格1,規格2,..]
    for spec in sku_specs:
        sku_key.append(spec.option_id)
    #取出當前商品所有規格鍵和對應sku_id建立字典
    skus = sku.goods.sku_set.all()
    key_sku_map = {}
    for s in skus:
        s_specs = s.skuspecification_set.order_by('spec_id')
        key = []
        for spec in s_specs:
            key.append(spec.option_id)
        key_sku_map[tuple(key)] = s.id  # {(規格1,規格2,..):sku_id,..)
    #獲取當前商品規格對象
    goods_specs = goods.goodsspecification_set.order_by('id')
    for index, spec in enumerate(goods_specs):
        #複製當前規格鍵
        key = sku_key[:]
        options = spec.specificationoption_set.all()
        for option in options:
            #查出當前商品對應的規格對象
            key[index] = option.id
            #從字典找出sku_id賦值
            option.sku_id = key_sku_map.get(tuple(key))
        spec.spec_options = options
    #構造響應數據
    context = {
        'categories': categories,
        'breadcrumb': breadcrumb,
        'sku': sku,
        'specs': goods_specs,
        'category_id': sku.category.id,
    }

    template = loader.get_template('detail.html')
    html_text = template.render(context)
    file_path = os.path.join(settings.STATICFILES_DIRS[0], 'details/' + str(sku_id) + '.html')
    with open(file_path, 'w') as f:
        f.write(html_text)

if __name__ == '__main__':
    skus = SKU.objects.all()
    for sku in skus:
        generate_static_sku_detail_html(sku.id)