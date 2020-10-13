let vm = new Vue({
    el: '#app',
    //修改Vue變量的讀取語法，避免和jinja2模板語法沖突
    delimiters: ['[[', ']]'],
    data: {
        username: '' ,
        cart_total_count: 0,
        carts: [],
        hot_skus: [],
        categories: '' ,
        category_id: category_id ,
        api: api ,
    },
    mounted(){
        //獲取購物車數據
        this.get_carts();

        //獲取暢銷商品數據
        this.get_hot_skus();

        this.username = getCookie('username');
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
        //獲取暢銷商品數據
        get_hot_skus(){
            let url = this.api.HotGoodUrl + this.category_id + '/';
            axios.get(url, {
                responseType: 'json'
            }).then(response => {
                    this.hot_skus = response.data.hot_skus;
                    for (var i = 0; i < this.hot_skus.length; i++) {
                        this.hot_skus[i].url = '/detail/' + this.hot_skus[i].id + '/';
                    }
                }).catch(error => {
                    console.log(error.response);
                })
        },
    }
});