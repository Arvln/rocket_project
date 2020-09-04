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
    },
    mounted(){
      //頁面刷新時，生成圖形驗證碼
      this.generate_image_code();
    },
    methods:{
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