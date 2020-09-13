from django.shortcuts import render
from django.http import JsonResponse
from django.views import View
from django.core.cache import cache
import logging

from areas.models import Area
from utils.response_code import RETCODE
from . import constants

# Create your views here.

logger = logging.getLogger('django')

class AreaView(View):
    """獲取用戶所在地區"""
    def get(self ,request ):

        #提取緩存區域列表數據
        area_list = cache.get('area_list')
        #接收參數
        area_id = request.GET.get('area_id')
        #判斷當前查的行政區級別
        if not area_id:
            #判斷是否存在緩存數據
            if not area_list:
                #請求區域級數據
                try:
                    area_model_list = Area.objects.filter(parent__isnull=True)
                    area_list = []
                    for area in area_model_list:
                        area_dict = {
                            'id':area.id ,
                            'name':area.name ,
                        }
                        area_list.append(area_dict)
                    #緩存區域列表數據
                    cache.set('area_list' ,area_list ,constants.AREA_LIST_EXPIRES )
                except Exception as e:
                    logger.error(e)
                    return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'查詢區域數據錯誤' })

            return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'area_list':area_list })
        else:
            #提取緩存縣市或區鎮列表數據
            sub_data = cache.get('sub_area_' + area_id )
            #判斷是否存在緩存數據
            if not sub_data:
                #請求縣市或區鎮數據
                try:
                    parent = Area.objects.get(id=area_id)
                    #sub_model_list = Area.objects.filter(parent_id=area_id)
                    sub_model_list = parent.subs.all() #related_name關聯查詢
                except Exception as e:
                    logger.error(e)
                    return JsonResponse({'code':RETCODE.DBERR ,'errmsg':'查詢縣市或區鎮數據錯誤' })
                #構造響應數據
                sub_list = []
                for sub in sub_model_list:
                    sub_dict = {
                        'id':sub.id ,
                        'name':sub.name ,
                    }
                    sub_list.append(sub_dict)
                sub_data = {
                    'id':parent.id ,
                    'name':parent.name ,
                    'subs':sub_list
                }
                #緩存縣市或區鎮列表數據
                cache.set('sub_area_' + area_id ,sub_data ,constants.AREA_LIST_EXPIRES )

            #返回響應
            return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'sub_data':sub_data })
