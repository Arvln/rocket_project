let vm = new Vue({
    el: '#app',
    //修改Vue變量的讀取語法，避免和jinja2模板語法沖突
    delimiters: ['[[', ']]'],
    data: {
        username: '' ,
        cart_total_count: 0, // 购物车总数量
        carts: [], // 购物车数据,
        hot_skus: [],
        categories: '' ,
        category_id: category_id ,
        api: api ,
    },
    mounted(){
        // 获取购物车数据
        this.get_carts();

        //獲取暢銷商品數據
        this.get_hot_skus();

        this.username = getCookie('username');
    },
    methods: {
        // 获取购物车数据
        get_carts(){
            var url = '/carts/simple/';
            axios.get(url, {
                responseType: 'json',
            })
                .then(response => {
                    this.carts = response.data.cart_skus;
                    this.cart_total_count = 0;
                    for (var i = 0; i < this.carts.length; i++) {
                        if (this.carts[i].name.length > 25) {
                            this.carts[i].name = this.carts[i].name.substring(0, 25) + '...';
                        }
                        this.cart_total_count += this.carts[i].count;
                    }
                })
                .catch(error => {
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
        }
    }
});