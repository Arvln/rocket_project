from django.urls import reverse
from django.shortcuts import redirect

from settings.dev import SECRET_KEY ,Line_ChannelID ,Line_Channel_secret
import requests ,json
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer ,BadData
from . import constants

headers = {
    'Content - Type': 'application / x - www - form - urlencoded',
    'Referer': 'http://192.168.126.130:8000/api/line/login/',
    'User-Agent': 'Mozilla / 5.0(X11;Linuxx86_64) AppleWebKit / 537.36(KHTML, likeGecko) Chrome / 85.0.4183.83Safari / 537.36}',
}

def get_id_token(code):
    """請求id_token"""
    url = 'https://api.line.me/oauth2/v2.1/token'
    redirect_url = 'http://192.168.126.130:8000' + reverse('oauth:line_login')
    form_data = {
        'grant_type':'authorization_code' ,
        'code':code ,
        'redirect_uri':redirect_url ,
        'client_id':Line_ChannelID ,
        'client_secret':Line_Channel_secret ,
    }
    results = requests.post(url=url ,data=form_data ,headers=headers ).text
    json_dict = json.loads(results)
    id_token = json_dict.get('id_token')
    return id_token

def get_profile_information(id_token ,state ):
    """驗證並解碼id_token"""
    url = 'https://api.line.me/oauth2/v2.1/verify'
    form_data = {
        'id_token':id_token ,
        'client_id':Line_ChannelID ,
    }
    results = requests.post(url=url ,data=form_data ,headers=headers ).text
    json_dict = json.loads(results)
    json_dict['state'] = state
    picture = json_dict.get('picture')
    userid = json_dict.get('sub')
    return picture ,userid ,json_dict

def generate_access_token(data):
    """序列化數據"""
    # 創建序列化器對象
    s = Serializer(SECRET_KEY ,constants.ACCESS_TOKEN_EXPIRES )
    # 準備待序列化數據
    data = data
    # 序列化數據:bytes類型
    token = s.dumps(data).decode()
    # 返回序列化數據token
    return token

def check_access_token(access_token):
    """反序列化數據"""
    # 創建序列化器對象
    s = Serializer(SECRET_KEY ,constants.ACCESS_TOKEN_EXPIRES )
    # 準備序列化數據
    access_token = access_token
    # 反序列化數據，校驗access_token是否過期
    try:
        data = s.loads(access_token)
    except BadData:
        return None
    # 返回數據
    return data