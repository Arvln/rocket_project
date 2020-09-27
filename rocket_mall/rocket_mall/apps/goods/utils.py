


def get_breadcrumb(category):
    """
    獲取麵包屑導航
    :params:可為一級、二級、三級對象
    :return:一級返回一級/二級返回一級+二級/三級返回所有類別
    """
    #響應數據
    breadcrumb = {
        'cat1': '',
        'cat2': '',
        'cat3': '',
    }
    #判斷是否是一級
    if category.parent is None:
        #category為一級
        breadcrumb['cat1'] = category
    elif category.subs.count() == 0:
        #GoodsCategory.objects.filter(parent=category).count() == 0
        #category為三級
        cat2 = category.parent
        breadcrumb['cat1'] = cat2.parent
        breadcrumb['cat2'] = cat2
        breadcrumb['cat3'] = category
    else:
        #category為二級
        breadcrumb['cat1'] = category.parent
        breadcrumb['cat2'] = category

    return breadcrumb