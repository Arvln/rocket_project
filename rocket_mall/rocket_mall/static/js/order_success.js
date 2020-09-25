let vm = new Vue({
    el: '#app',
	//修改Vue變量的讀取語法，避免和jinja2模板語法衝突
    delimiters: ['[[', ']]'],
    data: {
        username: getCookie('username') ,

        order_id: '' ,
        payment_amount: '' ,
        pay_method: '' ,

        api: api ,
    },
    mounted(){
        //獲取訂單資訊
        this.get_orders() ;
    },
    methods: {
        //獲取訂單資訊
        get_orders(){
            let url = this.api.OrderSeccessUrl ;
            axios.get(url ,{
                params: {
                   orders: 'orders' ,
                },
                responseType: 'json' ,
            }).then(response=>{
                this.order_id = response.data.orders.order_id ;
                this.payment_amount = response.data.orders.payment_amount ;
                this.pay_method = response.data.orders.pay_method ;
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //支付訂單
        order_payment(){
            var order_id = get_query_string('order_id');
            var url = '/payment/' + order_id + '/';
            axios.get(url, {
                    responseType: 'json'
                })
                .then(response => {
                    if (response.data.code == '0') {
                        //跳轉到支付寶
                        location.href = response.data.alipay_url;
                    } else if (response.data.code == '4101') {
                        location.href = '/login/?next=/orders/info/1/';
                    } else {
                        console.log(response.data);
                        alert(response.data.errmsg);
                    }
                })
                .catch(error => {
                    console.log(error.response);
                })
        },
    }
});