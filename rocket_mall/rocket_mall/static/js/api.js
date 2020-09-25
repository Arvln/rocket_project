const ApiRootUrl = 'http://192.168.126.130:8000/api/';

const api = {
    UsernamecountUrl: ApiRootUrl + 'usernames/get/', //用戶名數量查詢接口
    MobilecountUrl: ApiRootUrl + 'mobiles/get/', //手機號碼數量查詢接口
    ImagecodeUrl: ApiRootUrl + 'image_codes/get/', //獲取圖形驗證碼接口
    SMScodeUrl: ApiRootUrl + 'sms_codes/get/', //獲取簡訊驗證碼接口
    CheckSMScodeUrl: ApiRootUrl + 'sms_code/get/', //校驗簡訊驗證碼接口
    LoginUrl: ApiRootUrl + 'login_info/', //用戶登入接口
    CheckuserUrl: ApiRootUrl + 'login_info/get/', //校驗登入用戶接口
    LineLoginUrl: ApiRootUrl + 'line/login_url/get/', //獲取line用戶登入授權頁面接口
    LineRegisterUrl: ApiRootUrl + 'line/login/', //使用Authorization Code，進行line用戶登入程序的接口
    EmailUrl: ApiRootUrl + 'email/put/', //更新用戶Email接口
    AreaUrl: ApiRootUrl + 'areas/get/', //獲取用戶所在地區接口
    AddressUrl: ApiRootUrl +'addresses/post/', //新增用戶收貨地址接口
    ModifyRemoveAddressUrl: ApiRootUrl + 'addresses/put_delete/', //修改或刪除用戶收貨地址接口
    DefaultAddressUrl: ApiRootUrl + 'addresses/default/put/', //設置默認地址接口
    AddressTitleUrl: ApiRootUrl + 'addresses/title/put/', //修改地址標題接口
    HotGoodUrl: ApiRootUrl + 'hot_good/get/', //查詢暢銷商品的接口
    DetailVisitUrl: ApiRootUrl + 'guest/', //統計分類商品訪問量的接口
    UserBrowseHistoryUrl: ApiRootUrl + 'browse_histories/', //保存用戶商品瀏覽紀錄的接口\
    CartsUrl: ApiRootUrl + 'carts/', //獲取、新增、修改、刪除購物車資訊的接口
    CartsSelectAllUrl: ApiRootUrl + 'carts/selection/', //購物車全選的接口
    OrderInfoUrl: ApiRootUrl + 'orders/info/', //返回訂單結算頁面的接口
    OrderSettlementUrl: ApiRootUrl + 'orders/settlement/', //查詢訂單結算數據的接口
    OrderSubmitUrl: ApiRootUrl +'orders/submission/' , //提交訂單的接口
    OrderSeccessUrl: ApiRootUrl + 'orders/seccess/' , //提交訂單成功頁面或查詢訂單數據的接口
}