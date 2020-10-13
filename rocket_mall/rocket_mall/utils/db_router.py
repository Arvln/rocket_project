class MasterSlaveDBRouter(object):
    """數據庫讀寫路由"""

    def db_for_read(self, model, **hints):
        """查詢服務器"""
        return "slave"

    def db_for_write(self, model, **hints):
        """寫入服務器"""
        return "default"

    def allow_relation(self, obj1, obj2, **hints):
        """進行關聯查詢"""
        return True