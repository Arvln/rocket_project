let vm = new Vue({
    el: '#app',
    //修改Vue變量的讀取語法，避免和jinja2模板語法衝突
    delimiters: ['[[', ']]'],
    data: {
        username: getCookie('username') ,
        orders: [] ,
        page_num: '' ,
        total_page: '' ,
        carts: [] ,

        api: api ,
    },
    mounted(){
        //獲取購物車數據
        this.get_carts();
    },
    methods: {
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
