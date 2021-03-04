# rocket_project
## 技術選型
* 購物網站分為前台和後台<br>
* 前台Api採Django類視圖構建，後台Api以Django Rest Framework構建<br>
* 簡訊驗證碼和Email確認信等服務使用Celery搭建分布式服務<br>
* 資料結合快取服務Redis / 資料庫服務MySQL / Django ORM操作<br>
* 使用Elasticsearch建構商品搜索服務<br>
* 串接LINE登入和支付寶支付服務<br>
* 前端採用Jinja2和Vue.js渲染<br>

## 運行項目步驟

#### 以下命令以Mac OSX或Linux環境為例。
* 創建一個資料夾<br>
git clone https://github.com/Arvln/rocket_project.git

* 進到項目中rocket_project目錄下，找到docker-compose.yml<br>
sudo docker-compose up -d

* 打開瀏覽器訪問網站<br>
http://127.0.0.1:80

## 體驗前注意事項
* Nginx服務運行在本機80和443端口，若您正在運行Apache、Nginx或其他服務請先關閉

* 若您想完整體驗註冊流程，需到Twilio申請試用帳號，再到rocket_project/rocket_mall/celery_tasks/sms目錄下，修改sms.py中的account_sid、auth_token、from_三個參數為您的Twilio帳戶配置<br>

  Twilio註冊網址:https://www.twilio.com/try-twilio

* 若您不想註冊Twilio帳號，卻想體驗註冊流程，請在發送簡訊驗證碼後，到rocket_project/rocket_mall/logs/rocket.log文件中查看簡訊驗證碼

* 若您想略過註冊快速體驗登入用戶權限，請使用測試帳號，帳號名稱:testuser/密碼:12345678或在tb_user表中創建新用戶

* 若您想查看商品詳情，左側商品分類中第一列手機->手機通訊->拍照手機 / 第二列電腦->電腦->筆記型電腦 已收錄數據可供瀏覽

* 若您使用支付寶付款，買家帳號:ecwgce2117@sandbox.com / 登錄密碼:111111 / 支付密碼:111111，即可使用支付寶沙箱環境進行支付

* 祝您使用愉快!若有任何疑問或建議請來信:Arvinchen1995@gmail.com，期待很快能有機會向您請教，謝謝!
