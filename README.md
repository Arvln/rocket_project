# rocket_project
## 運行項目步驟

#### 以下命令以Mac OSX或Linux環境為例。
* 創建一個資料夾<br>
git clone https://github.com/Arvln/rocket_project.git

* 進到項目中rocket_project目錄下，找到docker-compose.yml<br>
sudo docker-compose up -d

* 準備商城圖片數據<br>
mv ./compose/fastdfs/ /tmp/

* 創建文件存儲容器，指定當前Tracker Server的ip地址(EX:192.168.126.130，不可用127.0.0.1)<br>
sudo docker run -dit --name tracker --network=rocket_project_fastdfs_net -v /tmp/fastdfs/tracker:/var/fdfs delron/fastdfs tracker<br>
sudo docker run -dit --name storage --network=rocket_project_fastdfs_net -e TRACKER_SERVER=192.168.126.130:22122 -v /tmp/fastdfs/storage:/var/fdfs delron/fastdfs storage

* 啟動商城容器組服務<br>
sudo docker exec -ti rocket_project_web_1 /bin/bash start.sh&<br>

* 打開瀏覽器訪問網站<br>
http://127.0.0.1:80

## 體驗前注意事項
* 若您想完整體驗註冊流程，需到Twilio申請試用帳號，再到rocket_project/rocket_mall/celery_tasks/sms目錄下，修改sms.py中的account_sid、auth_token、from_三個參數為您的帳戶配置<br>

  Twilio註冊網址:https://www.twilio.com/try-twilio

* 若您不想註冊Twilio帳號，卻想體驗註冊流程，請在發送簡訊驗證碼後，到rocket_project/rocket_mall/logs/rocket.log/文件中查看簡訊驗證碼

* 若您想快速體驗登入用戶權限，請使用測試帳號，帳號名稱:testuser/密碼:12345678或在tb_user表中創建新用戶

* 若您想查看商品詳情，左側商品分類中第一列手機->手機通訊->拍照手機 / 第二列電腦->電腦->筆記型電腦 已收錄數據可供瀏覽

* 祝您使用愉快!若有任何疑問或建議請來信:Arvinchen1995@gmail.com，期待很快能有機會向您請教，謝謝!
