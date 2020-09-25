let vm = new Vue({
    el: '#app',
	//修改Vue變量的讀取語法，避免和jinja2模板語法衝突
    delimiters: ['[[', ']]'],
    data: {
        username: getCookie('username') ,
        order_submitting: false ,
        pay_method: 2 ,
        //結算訂單數據
        orders: {} ,
        addresses: [] ,
        default_address_id: '' ,
        mobile:'' ,
        skus: [] ,
        total_count:'' ,
        total_amount:'' ,
        freight:'' ,
        total_payment:'' ,

        api: api ,
    },
    mounted(){
        //查詢結算訂單數據
        this.get_orders() ;
    },
    methods: {
        //選定寄送地址與默認地址連動
        set_default(index) {
            let url = this.api.DefaultAddressUrl + this.addresses[index].id + '/' ;
            axios.put(url ,{} ,{
                headers: {
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType: 'json' ,
            }).then(response=>{
                console.log(response.data) ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //查詢結算訂單數據
        get_orders(){
            let url = this.api.OrderSettlementUrl ;
            axios.get(url ,{
                responseType: 'json' ,
            }).then(response=>{
                this.orders = response.data.orders ;
                this.addresses = this.orders.addresses ;
                this.default_address_id = this.orders.default_address_id ;
                this.mobile = this.orders.mobile ;
                this.skus = this.orders.skus ;
                this.total_count = this.orders.total_count ;
                this.total_amount = this.orders.total_amount ;
                this.freight = this.orders.freight ;
                this.total_payment = this.orders.total_payment ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //提交訂單
        on_order_submit(){
            if (!this.default_address_id) {
                alert('請編寫收貨地址');
                return;
            }
            if (!this.pay_method) {
                alert('請選擇付款方式');
                return;
            }
            let url = this.api.OrderSubmitUrl ;
            axios.post(url ,{
                address_id:this.default_address_id ,
                pay_method:this.pay_method ,
            },{
                headers: {
                    'X-CSRFToken':getCookie('csrftoken') ,
                },
                responseType: 'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    location.href = this.api.OrderSeccessUrl + '?order_id=' + response.data.order_id ;
                } else if (response.data.code === '5007'){
                    alert(response.data.errmsg) ;
                    location.href = this.api.CartsUrl ;
                } else {
                    alert(response.data.errmsg) ;
                    location.href = this.api.OrderInfoUrl ;
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
    }
});