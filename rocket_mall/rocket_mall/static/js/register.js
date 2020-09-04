let vm = new Vue({
    el: '#app',
    delimiters: ['[[' ,']]' ],
    data:{

        username: '',
        password: '',
        password2: '',
        mobile: '',
        piccode: '',
        sms_code: '',
        allow: true,

        error_username: false,
        error_password: false,
        error_password2: false,
        error_mobile: false,
        error_piccode: false,
        error_sms_code: false,
        error_allow: false,

        error_username_tip: '',
        error_mobile_tip: '',
        error_piccode_tip: '',
        error_sms_code_tip: '',
        sms_code_tip: '獲取簡訊驗證碼',

        username_ph: '用戶名稱',
        password_ph: '設置密碼',
        password2_ph: '確認密碼',
        mobile_ph: '建議使用常用手機號碼',
        piccode_ph: '請輸入圖形驗證碼',
        sms_code_ph: '請輸入簡訊驗證碼',

        api: api,
        uuid: '',
        image_code_url: '',
        send_flag: false,
    },
    mounted(){
      //頁面刷新時，生成圖形驗證碼
      this.generate_image_code();
    },
    methods:{
        //生成圖形驗證碼
        send_sms_code(){
           //前端避免惡意用戶頻繁獲取簡訊驗證碼
           if (this.send_flag === true){
               return;
           }
           this.send_flag = true;
           //前端校驗參數
           this.check_mobile();
           this.check_piccode();
           if (this.error_mobile === true || this.error_piccode === true){
               this.send_flag = false;
               return;
           }
           let url = this.api.SMScodeUrl + this.mobile + '/?img_code=' +this.piccode + '&uuid=' + this.uuid ;
           axios.get(url ,{
               responseType:'json'
           }).then(response=>{
               if (response.data.code === '0'){
                   let num = 120;
                   let t = setInterval(()=>{
                       if (num === 1){
                          clearInterval(t);
                          this.sms_code_tip = '重新獲取';
                          this.send_flag = false;
                          this.generate_image_code();
                       } else {
                          num -= 1;
                          this.sms_code_tip = num + 's後重新獲取';
                       }
                   },1000)
               } else {
                   if (response.data.code === '4001'){
                       this.error_piccode_tip = response.data.errmsg;
                       this.error_piccode = true;
                       this.send_flag = false;
                   } else {
                       this.error_sms_code_tip = response.data.errmsg;
                       this.error_sms_code = true ;
                   }
               }
           }).catch(error=>{
               console.log(error.response);
               this.send_flag = false;
           })
        },
        //封裝生成圖形驗證碼函數
        generate_image_code(){
           this.uuid = generateUUID();
           this.image_code_url = this.api.ImagecodeUrl + this.uuid + '/';
        },
        check_username(){
            let re = /^[a-zA-Z0-9_-]{5,20}$/;
            if (re.test(this.username)){
                this.error_username = false;
            } else {
                this.error_username_tip = '請輸入5~20個字符的用戶名稱';
                this.error_username = true;
            }
            if (this.error_username === false){
                let url = this.api.UsernamecountUrl + this.username + '/';
                axios.get(url ,{
                    responseType:'json' ,
                }).then(response=>{
                    if (response.data.count === 1){
                        this.error_username_tip = '用戶名稱已存在';
                        this.error_username = true;
                    } else {error=>{
                        this.error_username = false;
                    }}
                }).catch(error=>{
                    console.log(error.response);
                })
            }
        },
        check_password(){
            let re = /^[a-zA-Z0-9_-]{8,12}$/;
            if (re.test(this.password)){
                this.error_password = false;
            } else {
                this.error_password = true;
            }
        },
        check_password2(){
            if (this.password === this.password2){
                this.error_password2 = false;
            } else {
                this.error_password2 = true;
            }
        },
        check_mobile(){
            let re = /^09\d{8}$/;
            if (re.test(this.mobile)){
                this.error_mobile = false;
            } else {
                this.error_mobile_tip = '您輸入的手機號碼格式不正確';
                this.error_mobile = true;
            }
            if (this.error_mobile === false){
                let url = this.api.MobilecountUrl + this.mobile + '/';
                axios.get(url ,{
                    responseType: 'json'
                }).then(response=>{
                    if (response.data.count === 1){
                        this.error_mobile_tip = '手機號碼已被註冊過';
                        this.error_mobile = true;
                    } else {
                        this.error_mobile = false;
                    }
                }).catch(error=>{
                    console.log(error.response);
                })
            }
        },
        check_piccode(){
            if (this.piccode.length != 4){
                this.error_piccode_tip = '請輸入4位數字或字母的圖形驗證碼';
                this.error_piccode = true;
            } else {
                this.error_piccode = false;
            }
        },
        check_sms_code(){
            let re = /^[\d]{6}$/;
            if (!re.test(this.sms_code) || this.sms_code.length != 6){
                this.error_sms_code_tip = '請填寫6位數字簡訊驗證碼';
                this.error_sms_code = true;
            } else {
                this.error_sms_code = false;
            }
            if (this.error_sms_code === false){
                let url = this.api.CheckSMScodeUrl + this.mobile + '/?sms_code=' + this.sms_code ;
                axios.get(url ,{
                    responseType:'json'
                }).then(response=>{
                    if (response.data.code === '4008'){
                        this.error_sms_code_tip = response.data.errmsg;
                        this.error_sms_code = true;
                    } else {
                        this.error_sms_code = false;
                    }
                }).catch(error=>{
                    console.log(error.response);
                })
            }
        },
        check_allow(){
            if (!this.allow){
                this.error_allow = true;
            } else {
                this.error_allow = false;
            }
        },
        on_submit(){
            this.check_username();
            this.check_password();
            this.check_password2();
            this.check_mobile();
            this.check_piccode();
            this.check_sms_code();
            this.check_allow();
            if (
                this.error_username === true || this.error_password === true ||
                this.error_password2 === true || this.error_mobile === true ||
                this.error_piccode === true || this.error_sms_code === true ||
                this.error_allow === true
            ){
               window.event.returnValue = false;
            }
        },
    },
})