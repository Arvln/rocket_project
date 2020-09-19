from collections import OrderedDict

from goods.models import GoodsChannel


def get_categories():
    """獲取商品分類"""

    #存儲商品分類的字典
    categories = OrderedDict()
    #查詢所有頻道組id:11個頻道組id
    #查詢所有頻道對象並按照1-11組順序排
    channels = GoodsChannel.objects.order_by('group_id', 'sequence')
    for channel in channels:
        group_id = channel.group_id  # 37個重複頻道組id
        if group_id not in categories:
            #構造11個頻道劃分的數據結構
            categories[group_id] = {'channels': [], 'sub_cats': []}
        #插入一級數據:從頻道對象的外鍵點出一級數據對象
        cat1 = channel.category
        cat1.url = ''
        cat1.url = channel.url
        categories[group_id]['channels'].append(cat1)
        #查詢二級和三級類別對象
        for cat2 in cat1.subs.all():
            #為二級類別對象新增存放三級類別對象的列表
            cat2.sub_cats = []
            for cat3 in cat2.subs.all():
                cat2.sub_cats.append(cat3)
            #插入二級和三級數據到一級數據列表
            categories[group_id]['sub_cats'].append(cat2)

    return categories