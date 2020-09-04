const ApiRootUrl = 'http://192.168.126.130:8000/api/';

const api = {
    UsernamecountUrl: ApiRootUrl + 'usernames/count/', //用戶名數量查詢接口
    MobilecountUrl: ApiRootUrl + 'mobiles/count/', //手機號碼數量查詢接口
    ImagecodeUrl: ApiRootUrl + 'image_codes/', //獲取圖形驗證碼接口
    SMScodeUrl: ApiRootUrl + 'sms_codes/', //獲取簡訊驗證碼接口
}