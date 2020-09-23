let vm = new Vue({
    el: '#app',
    //修改Vue變量的讀取語法，避免和jinja2模板語法衝突
    delimiters: ['[[', ']]'],
    data: {
        username: getCookie('username') ,
        hot_skus: [],
        sku_id: sku_id,
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
        cart_total_count: 0 ,
        carts: [] ,
        api: api ,
    },
    mounted(){
        //獲取暢銷商品數據
        this.get_hot_goods();

        //保存用戶瀏覽紀錄
        this.save_browse_histories();

        //獲取購物車數據
        this.get_carts();

    },
    watch: {
        //監聽商品數據變化
        sku_count: {
            handler(newValue){
                this.sku_amount = (newValue * this.sku_price).toFixed(2);
            },
            immediate: true ,
        }
    },
    methods: {
        //加數量
        on_addition(){
            if (this.sku_count < 5) {
                this.sku_count++ ;
            } else {
                this.sku_count = 5 ;
                alert('商品已達購買上限!') ;
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
        //加入購物車
        add_carts(){
            let url = this.api.CartsUrl ;
            axios.post(url ,{
                sku_id:parseInt(this.sku_id) ,
                count:this.sku_count ,
            },{
                headers:{
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType:'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    console.log(response.data) ;
                    this.get_carts() ;
                } else {
                    alert(response.data.errmsg) ;
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
                    carts:'detail' ,
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