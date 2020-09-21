let vm = new Vue({
    el: '#app',
    //修改Vue變量的讀取語法，避免和jinja2模板語法沖突
    delimiters: ['[[', ']]'],
    data: {
        username: getCookie('username') ,
        hot_skus: [],
        //sku_id: sku_id,
        sku_count: 1,
        sku_price: sku_price,
        sku_amount: 0,
        category_id: category_id,
        tab_content: {
            detail: true,
            pack: false,
            comment: false,
            service: false
        },
        comments: [],
        score_classes: {
            1: 'stars_one',
            2: 'stars_two',
            3: 'stars_three',
            4: 'stars_four',
            5: 'stars_five',
        },
        cart_total_count: 0, // 购物车总数量
        carts: [], // 购物车数据,
        sku_id: sku_id ,
        api: api ,
    },
    mounted(){
        //獲取暢銷商品數據
        this.get_hot_goods();

        // 保存用户浏览记录
        this.save_browse_histories();

        // 获取购物车数据
        this.get_carts();

        // 获取商品评价信息
        this.get_goods_comment();

        this.username = getCookie('username');
    },
    watch: {
        //監聽商品數據變化
        sku_count: {
            handler(newValue){
                this.sku_amount = (newValue * this.sku_price).toFixed(2);
            },
            immediate: true
        }
    },
    methods: {
        //加數量
        on_addition(){
            if (this.sku_count < 5) {
                this.sku_count++ ;
            } else {
                this.sku_count = 5 ;
                alert('已達購買上限!') ;
            }
            this.sku_amount = (this.sku_count * this.sku_price).toFixed(2) ;
        },
        //減數量
        on_minus(){
            if (this.sku_count > 1) {
                this.sku_count-- ;
            }
            this.sku_amount = (this.sku_count * this.sku_price).toFixed(2) ;
        },
        //編輯商品數量
        edit_sku_count(){
            if (this.sku_count > 5) {
                this.sku_count = 5 ;
            }
            if (this.sku_count < 1) {
                this.sku_count = '' ;
            }
            this.sku_amount = (this.sku_count * this.sku_price).toFixed(2) ;
        },
        //商品數量非空檢查
        check_sku_count(){
            if (this.sku_count === ''){
                this.sku_count = 1 ;
            }
        },
        //控制商品資訊展示
        on_tab_content(name){
            this.tab_content = {
                detail: false,
                pack: false,
                comment: false,
                service: false
            };
            this.tab_content[name] = true;
        },
        //獲取暢銷商品數據
        get_hot_goods(){
            let url = this.api.HotGoodUrl + this.category_id + '/';
            axios.get(url, {
                responseType: 'json'
            }).then(response => {
                this.hot_skus = response.data.hot_skus ;
                for (let i = 0; i < this.hot_skus.length; i++) {
                    this.hot_skus[i].url = '/detail/' + this.hot_skus[i].id + '/' ;
                }
                //統計分類商品訪問量
                this.detail_visit();
            }).catch(error => {
                console.log(error.response);
            })
        },
        //保存用戶商品瀏覽紀錄
        save_browse_histories(){
            let url = this.api.UserBrowseHistoryUrl ;
            axios.post(url ,{
                'sku_id':this.sku_id ,
            },{
                headers:{
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType:'json' ,
            }).then(response=>{
                console.log(response.data) ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //統計分類商品訪問量
        detail_visit(){
            let url = this.api.DetailVisitUrl + this.category_id + '/';
            axios.post(url ,{} ,{
                headers:{
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType:'json' ,
            }).then(response=>{
                console.log(response.data) ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        // 加入购物车
        add_cart(){
            var url = this.host + '/carts/';
            axios.post(url, {
                sku_id: parseInt(this.sku_id),
                count: this.sku_count
            }, {
                headers: {
                    'X-CSRFToken': getCookie('csrftoken')
                },
                responseType: 'json',
                withCredentials: true
            })
                .then(response => {
                    if (response.data.code == '0') {
                        alert('添加购物车成功');
                        this.cart_total_count += this.sku_count;
                    } else { // 参数错误
                        alert(response.data.errmsg);
                    }
                })
                .catch(error => {
                    console.log(error.response);
                })
        },
        // 获取购物车数据
        get_carts(){
            var url = this.host + '/carts/simple/';
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
        // 获取商品评价信息
        get_goods_comment(){
            if (this.sku_id) {
                var url = this.hots + '/comment/' + this.sku_id + '/';
                axios.get(url, {
                    responseType: 'json'
                })
                    .then(response => {
                        this.comments = response.data.goods_comment_list;
                        for (var i = 0; i < this.comments.length; i++) {
                            this.comments[i].score_class = this.score_classes[this.comments[i].score];
                        }
                    })
                    .catch(error => {
                        console.log(error.response);
                    });
            }
        },
    }
});