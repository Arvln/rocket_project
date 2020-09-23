let vm = new Vue({
    el: '#app',
    //修改Vue變量的讀取語法，避免和jinja2模板語法衝突
    delimiters: ['[[', ']]'],
    data: {
        username: getCookie('username'),
        carts: carts,
        total_count: 0,
        total_selected_count: 0,
        total_selected_amount: 0,

        api: api ,
    },
    computed: {
        //用戶勾選操作後，計算當前勾選狀態
        selected_all(){
            let selected = true;
            for (let i = 0; i < this.carts.length; i++) {
                if (this.carts[i].selected == false) {
                    selected = false;
                    break;
                }
            }
            return selected;
        },
    },
    mounted(){
        //初始化購物車數據
        this.render_carts();

        //計算購物車商品總數量
        this.compute_total_count();

        //計算已勾選商品總數量、總金額
        this.compute_total_selected_amount_count();
    },
    methods: {
        //初始化購物車數據
        render_carts(){
            //渲染界面
            this.carts = JSON.parse(JSON.stringify(carts)) ;
            for (let i=0; i<this.carts.length; i++){
                //vue無法識別'True'字符串，需重新賦值
                if (this.carts[i].selected === 'True'){
                    this.carts[i].selected = true ;
                } else {
                    this.carts[i].selected = false ;
                }
            }
        },
        //計算購物車商品總數量
        compute_total_count(){
            let total_count = 0 ;
            for (let i=0; i<this.carts.length; i++){
                total_count += this.carts[i].count ;
            }
            this.total_count = total_count ;
        },
        //計算已勾選商品總數量、總金額
        compute_total_selected_amount_count(){
            let total_selected_count= 0 ;
            let total_selected_amount= 0 ;
            for (let i=0; i<this.carts.length ;i++){
                if (this.carts[i].selected == true){
                    total_selected_count += parseInt(this.carts[i].count) ;
                    total_selected_amount += parseFloat(this.carts[i].price) * parseInt(this.carts[i].count) ;
                }
            }
            this.total_selected_count = total_selected_count ;
            //商品訂單總金額取到小數第二位
            this.total_selected_amount = total_selected_amount.toFixed(2) ;
        },
        //減少購買商品
        on_minus(index){
            let count=this.carts[index].count ;
            if (count>1){
                count -= 1 ;
                this.update_count(index, count) ;
            } else {
                alert('請刪除商品!') ;
            }
        },
        //增加購買商品
        on_add(index){
            let count=this.carts[index].count ;
            if (count<5){
                count += 1 ;
                this.update_count(index, count) ;
            } else {
                alert('商品已達購買上限!') ;
            }
        },
        //數量輸入框
        on_input(index){
            let count = parseInt(this.carts[index].count) ;
            if (isNaN(count)||count<1){
                count = 1 ;
            } else if (count>5){
                count = 5 ;
            }
            this.update_count(index ,count ) ;
        },
        //修改購物車商品數量
        update_count(index, count){
            let url = this.api.CartsUrl ;
            axios.put(url ,{
                sku_id:this.carts[index].id ,
                count:count ,
                selected:this.carts[index].selected ,
            },{
                headers:{
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType:'json' ,
                withCredentials:true ,
            }).then(response=>{
                Vue.set(this.carts ,index ,response.data.cart_sku ) ;
                //重新計算
                this.compute_total_count();
                this.compute_total_selected_amount_count();
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //更新購物車勾選數據
        update_selected(index) {
            let url = this.api.CartsUrl ;
            axios.put(url ,{
                sku_id:this.carts[index].id ,
                count:this.carts[index].count ,
                selected:this.carts[index].selected ,
            },{
                headers:{
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType:'json' ,
                withCredentials:true ,
            }).then(response=>{
                this.carts[index].selected = response.data.cart_sku.selected ;
                //重新計算
                this.compute_total_count() ;
                this.compute_total_selected_amount_count() ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //删除購物車數據
        on_delete(index){
            let url = this.api.CartsUrl ;
            axios.delete(url ,{
                data:{
                   sku_id:this.carts[index].id ,
                },
                headers:{
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType:'json' ,
                withCredentials: true ,
            }).then(response=>{
                this.carts.splice(index ,1 ) ;
                this.compute_total_count() ;
                this.compute_total_selected_amount_count() ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //購物車全選
        on_selected_all(){
            //用戶按下全選選項後，對當前勾選狀態取反
            let selected = !this.selected_all ;
            let url = this.api.CartsSelectAllUrl ;
            axios.put(url , {
                selected
            }, {
                headers: {
                    'X-CSRFToken': getCookie('csrftoken')
                },
                responseType: 'json',
                withCredentials: true
            }).then(response => {
                for (let i = 0; i < this.carts.length; i++) {
                    this.carts[i].selected = selected ;
                }
                //重新計算
                this.compute_total_count();
                this.compute_total_selected_amount_count() ;
            }).catch(error => {
                console.log(error.response) ;
            })
        },
    }
});