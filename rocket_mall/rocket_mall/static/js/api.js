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
    LineRegisterUrl: ApiRootUrl + 'line/login/', //按照授權結果，進行line用戶登入接口
    EmailUrl: ApiRootUrl + 'email/put/', //更新用戶Email接口
    AreaUrl: ApiRootUrl + 'areas/get/', //獲取用戶所在地區接口
    AddressUrl: ApiRootUrl +'addresses/post/', //新增用戶收貨地址接口
    ModifyRemoveAddressUrl: ApiRootUrl + 'addresses/put_delete/', //修改或刪除用戶收貨地址接口
    DefaultAddressUrl: ApiRootUrl + 'addresses/default/put/', //設置默認地址接口
    AddressTitleUrl: ApiRootUrl + 'addresses/title/put/', //修改地址標題接口
}