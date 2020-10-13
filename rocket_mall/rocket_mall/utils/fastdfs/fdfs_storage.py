from django.core.files.storage import Storage
from settings import FASTDFS_BASE_URL

class FastdfsStorage(Storage):
    """自定義文件存儲類"""
    def __init__(self ,fdfs_base_url=None):

        self.fdfs_base_url = fdfs_base_url or FASTDFS_BASE_URL

    def url(self, name):

        return self.fdfs_base_url + name
