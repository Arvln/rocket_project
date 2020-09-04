# -*- coding = utf-8 -*-
from twilio.rest import Client

def send(mobile ,verify_sms ,min ):
    account_sid = 'AC834631b579159bac3e70d87b0a5e0824'      #ACCOUNT SID
    auth_token = 'ab21851a2dcd6c3a59ff4f39f6fae4de'     #AUTH TOKEN
    client = Client(account_sid, auth_token)
    #send message
    mobile_client = mobile[1:]
    message = client.messages.create(
                         body=f'您的美多商城驗證碼為{verify_sms}，此驗證碼{min}分鐘內有效，提醒您，請勿將此驗證碼提供給其他人保障您的使用安全。',
                         from_='+18323583615',      #your number on twilio
                         to='+886' + mobile_client    #target phone
                     )