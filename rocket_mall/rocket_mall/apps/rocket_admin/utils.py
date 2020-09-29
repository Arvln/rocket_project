from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response

#重寫JWT返回結果
def jwt_response_payload_handler(token, user=None, request=None):
    return {
        'token':token ,
        'username':user.username ,
        'id':user.id ,
    }

#自定義分頁器
class PageNum(PageNumberPagination):

    page_size = 2
    page_size_query_param = 'pagesize'
    max_page_size = 10
    def get_paginated_response(self, data):
        return Response({
            'count':self.page.paginator.count ,
            'list':data ,
            'page':self.page.number ,
            'pages':self.page.paginator.num_pages ,
            'pagesize':self.max_page_size ,
        })