let vm = new Vue({
    el: '#app',
    //修改Vue變量的讀取語法，避免和jinja2模板語法衝突
    delimiters: ['[[', ']]'],
    data: {
        username:getCookie('username') ,
        old_pwd: '' ,
        new_pwd: '' ,
        new_pwd2: '' ,
        carts: [] ,

        error_opwd: false ,
        error_pwd: false ,
        error_pwd2: false ,

        default_opwd: '輸入密碼' ,
        default_new_pwd: '輸入新密碼' ,
        default_new_pwd2: '再次輸入密碼' ,

        api:api ,
    },
    mounted(){
        //獲取購物車數據
        this.get_carts();
    },
    methods: {
        //檢查舊密碼
        check_opwd(){
            let re = /^[a-zA-Z0-9_-]{8,12}$/ ;
            if (re.test(this.old_pwd)) {
                this.error_opwd = false ;
            } else {
                this.error_opwd = true ;
            }
        },
        //檢查新密碼
        check_pwd(){
            let re = /^[a-zA-Z0-9_-]{8,12}$/ ;
            if (re.test(this.new_pwd)) {
                this.error_pwd = false ;
            } else {
                this.error_pwd = true ;
            }
        },
        //檢查再次輸入新密碼
        check_pwd2: function () {
            if (this.new_pwd != this.new_pwd2) {
                this.error_pwd2 = true;
            } else {
                this.error_pwd2 = false;
            }
        },
        //提交密碼
        on_submit: function () {
            this.check_opwd();
            this.check_pwd();
            this.check_pwd2();

            if (this.error_opwd == true || this.error_pwd == true || this.error_pwd2 == true) {
                window.event.returnValue = false
            }
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
});