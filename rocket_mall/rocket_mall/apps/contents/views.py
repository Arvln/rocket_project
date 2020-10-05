from django.shortcuts import render
from django.views import View
from collections import OrderedDict

from contents.models import ContentCategory
from contents.utils import get_categories
# Create your views here.


class IndexView(View):
    """首頁廣告"""
    #需求:為提高SEO效率，首頁採用jinja2做SSR
    def get(self ,request ):
        """提供首頁廣告頁面"""
        #獲取商品分類
        categories = get_categories()
        #查詢首頁廣告
        contents = OrderedDict()
        content_categories = ContentCategory.objects.all()
        for content_category in content_categories:
            contents[content_category.key] = content_category.content_set.filter(status=True).order_by('sequence')
        #構造響應數據
        context = {
            'categories':categories ,
            'contents':contents ,
        }

        return render(request ,'index.html' ,context )