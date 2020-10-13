let vm = new Vue({
    el: '#app',
    delimiters: ['[[' ,']]' ],
    data:{
        //接收jinja2傳遞的數據
        username: username ,
        mobile: mobile ,
        email: email ,
        email_active: email_active ,

        //渲染的判斷依據
        set_email: true ,

        //提示訊息
        default_email: '建議使用常用Email' ,
        error_email: false ,
        error_email_tip: '' ,
        send_email_tip: '重新發送驗證Email' ,
        send_email_btn_disabled: false ,

        carts: [] ,

        //用戶瀏覽紀錄
        histories:[] ,
        ApiRootUrl: ApiRootUrl ,
        api: api ,
    },
    mounted(){
        //頁面刷新時，檢查Email是否存在
        this.set_email = (this.email === '') ? true : false ;
        //頁面刷新時，檢查Email是否驗證
        this.email_active = (this.email_active == 'True') ? true : false ;
        //獲取用戶瀏覽紀錄
        this.browse_histories() ;
        //獲取購物車數據
        this.get_carts();
    },
    methods:{
        //檢查Email格式
        check_email(){
            let re = /^[\w.-]+@[\w-]+(.[\w_-]+)+$/ ;
            if (re.test(this.email)){
                this.error_email = false ;
            } else {
                this.error_email_tip = '請確認Email格式是否正確' ;
                this.error_email = true ;
            }
        },
        //保存Email格式
        save_email(){
            let url = this.api.EmailUrl ;
            axios.put(url ,{
                'email': this.email ,
            },{
                headers : {
                    'X-CSRFToken':getCookie('csrftoken')
                },
                responseType: 'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    this.set_email = false ;
                    this.send_email_tip = '已發送驗證Email' ;
                    this.send_email_btn_disabled = true ;
                } else {
                    if (response.data.code === '4101'){
                        location.href = this.api.LoginUrl ;
                    } else {
                        console.log(response.data.errmsg) ;
                    }
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //不保存Email格式
        cancel_email(){
            this.email = '' ;
            this.error_email = false ;
        },
        //獲取用戶瀏覽紀錄
        browse_histories() {
            let url = this.api.UserBrowseHistoryUrl ;
            axios.get(url ,{
                responseType: 'json' ,
            }).then(response=>{
                this.histories = response.data.skus ;
                for (let i=0 ;i<this.histories.length ;i++ ){
                    this.histories[i].url = this.ApiRootUrl + 'detail/' +this.histories[i].id + '/' ;
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //獲取購物車數據
        get_carts(){
            let url = this.api.CartsUrl ;
            axios.get(url, {
                params: {
                    carts:'carts' ,
                },
                responseType: 'json',
            }).then(response => {
                this.carts = response.data.cart_skus ;
                let count = 0 ;
                for (let i=0; i<this.carts.length ;i++){
                    count += this.carts[i].count ;
                }
                this.cart_total_count = count ;
            }).catch(error => {
                console.log(error.response);
            })
        },
    }
})