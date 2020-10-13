var vm = new Vue({
    el: '#app',
    // 声明 vue在处理页面模板变量时使用[[ ]]当做变量语法
    delimiters: ['[[', ']]'],
    data: {
        //username: sessionStorage.username || localStorage.username,
        //user_id: sessionStorage.user_id || localStorage.user_id,
        //token: sessionStorage.token || localStorage.token,
        username: getCookie('username'),
        photo_url: getCookie('photo_url'),
        cart_total_count: 0,
        carts: [],
        f1_tab: 1,
        f2_tab: 1,
        f3_tab: 1,

        api:api ,
    },
    mounted: function(){
        //獲取購物車數據
        this.get_carts();
    },
    methods: {
        //退出
        logout: function(){
            sessionStorage.clear();
            localStorage.clear();
            location.href = '/login.html';
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