let vm = new Vue({
    el: '#app',
    delimiters: ['[[' ,']]' ],
    data:{

        username: '',
        access_token: access_token,
        picture: picture,
        allow: true,

        error_username: false,
        error_allow: false,
        error_username_tip: '',

        default_username: '用戶名稱',

        api: api,
    },
    mounted(){
      //頁面刷新時，生成圖形驗證碼
    },
    methods:{
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
        check_allow(){
            if (!this.allow){
                this.error_allow = true;
            } else {
                this.error_allow = false;
            }
        },
        on_submit(){
            this.check_username();
            this.check_allow();
            if (
                this.error_username === true || this.error_allow === true
            ){
               window.event.returnValue = false;
            }
        },
    },
})