from django.shortcuts import render
from django.http import HttpResponseForbidden ,HttpResponseNotFound ,JsonResponse
from django.views import View
from django.core.paginator import Paginator ,EmptyPage

from goods.models import GoodsCategory ,SKU
from contents.utils import get_categories
from goods.utils import get_breadcrumb
from utils.response_code import RETCODE
# Create your views here.


class ListView(View):
    """查詢商品分類數據接口"""

    # 為提高SEO效率，首頁採用jinja2做SSR
    def get(self, request, category_id, page_num):
        # 校驗category_id
        try:
            category = GoodsCategory.objects.get(id=category_id)
        except Exception as e:
            return HttpResponseForbidden('商品類別不存在')
        # 獲取商品分類
        categories = get_categories()

        # 查詢麵包屑導航
        breadcrumb = get_breadcrumb(category)

        # 分頁和排序查詢
        # 獲取並判斷排序規則
        sort = request.GET.get('sort', 'default')
        if sort == 'price':
            sort_field = 'price'
        elif sort == 'hot':
            sort_field = '-sales'
        else:
            sort = 'default'
            sort_field = 'create_time'
        skus = category.sku_set.filter(is_launched=True).order_by(sort_field)
        # 獲取當前分頁的商品數據
        paginator = Paginator(skus, 5)
        try:
            page_skus = paginator.page(page_num)
        except EmptyPage:
            return HttpResponseNotFound('頁面不存在')
        # 獲取總頁數
        total_page = paginator.num_pages

        # 構造響應數據
        context = {
            'categories': categories,
            'breadcrumb': breadcrumb,
            'page_skus': page_skus,
            'total_page': total_page,
            'page_num': page_num,
            'sort': sort,
            'category_id': category_id,
        }

        return render(request, 'list.html', context)

class HotGoodsView(View):
    """暢銷商品"""

    def get(self, request, category_id):

        # 校驗參數
        # 查詢銷量最高的前兩個上架商品
        try:
            skus = SKU.objects.filter(category_id=category_id, is_launched=True).order_by('-sales')[:2]
        except Exception as e:
            return HttpResponseForbidden('商品類別不存在')
        # 構造響應數據
        hot_skus = []
        for sku in skus:
            hot_skus.append({
                'id': sku.id,
                'default_image_url': sku.default_image_url,
                'name': sku.name,
                'price': sku.price,
            })
        return JsonResponse({'code': RETCODE.OK, 'errmsg': 'OK', 'hot_skus': hot_skus})