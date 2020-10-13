from collections import OrderedDict
from django.template import loader
import os

from contents.utils import get_categories
from contents.models import ContentCategory
from settings import STATICFILES_DIRS


def generate_static_index_html():
    """靜態化首頁"""
    #獲取商品分類
    categories = get_categories()
    #查詢首頁廣告
    contents = OrderedDict()
    content_categories = ContentCategory.objects.all()
    for content_category in content_categories:
        contents[content_category.key] = content_category.content_set.filter(status=True).order_by('sequence')
    #構造響應數據
    context = {
        'categories': categories,
        'contents': contents,
    }
    #渲染模板
    #先獲取模板文件
    template = loader.get_template('index.html')
    #用響應數據渲染模板
    html_text = template.render(context)
    #將模板文件寫到靜態路徑
    file_path = os.path.join(STATICFILES_DIRS[0], 'index.html')
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(html_text)