let vm = new Vue({
    el: '#app',
    delimiters: ['[[' , ']]'],
    data:{
       username: '',
       password: '',
       remembered: true,

       default_username: '手機號碼/用戶名稱/Email',
       default_password: '密碼',

       error_username: false,
       error_username_tip: '',
       error_password: false,
       error_password_tip: '',
       error_login: false,
       error_login_tip: '',

       api: api,
    },
    methods:{
        //檢查用戶名稱
        check_username(){
            if (this.username === ''){
                this.error_username_tip = '請輸入手機號碼、用戶名稱或Email';
                this.error_username = true;
            } else {
                this.error_username = false;
            }
        },
        //檢查密碼
        check_password() {
            if (this.password === ''){
                this.error_password_tip = '請輸入密碼'
                this.error_password = true;
            } else {
                this.error_password = false;
            }
        },
        //驗證用戶名稱和密碼
        verify_user(){
           if (this.error_username === false || this.error_password === false) {
                let url = this.api.CheckuserUrl + '?username=' + this.username + '&password=' +this.password ;
                axios.get(url ,{
                    responseType: 'json'
                }).then(response=>{
                    if (response.data.code === '0'){
                       this.error_login = false;
                    } else {
                       this.error_login_tip = response.data.errmsg;
                       this.error_login = true;
                    }
                })
            }
        },
        //登入表單提交
        on_submit(){
            this.check_username();
            this.check_password();
            if (
                this.error_username === true || this.error_password === true ||
                this.error_login === true
            ){
               window.event.returnValue = false;
            }
        },
        //line登入
        line_login(){
            let next = get_query_string('next') || '/' ;
            let url = this.api.LineLoginUrl + '?next=' + next ;
            axios.get(url ,{
                responseType: 'json'
            }).then(response=>{
                location.href = response.data.login_url ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
    },
})