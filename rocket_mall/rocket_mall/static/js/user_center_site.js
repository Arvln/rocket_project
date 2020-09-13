let vm = new Vue({
    el: '#app',
    delimiters: ['[[' , ']]' ],
    data:{
        //
        username: getCookie('username') ,
        //新增或修改地址表單
        form_address: {
           receiver: '' ,
           mobile: '' ,
           email: '' ,
           area_id: '' ,
           city_id: '' ,
           district_id: '' ,
           place: '' ,
        },
        areaes: [] ,
        cities: [] ,
        districts: [] ,
        addresses: [] ,
        default_address_id: default_address_id ,

        //提示訊息
        default_receiver: '姓名' ,
        default_mobile: '手機號碼' ,
        default_email: 'Email' ,
        default_place: '樓層、街/路...' ,
        error_receiver: false ,
        error_mobile: false ,
        error_email: false ,
        error_place: false ,

        //api
        api: api ,
    },
    mounted(){
        //頁面刷新時，獲取用戶所在地區數據
        this.get_area() ;
        //頁面刷新時，vue獲取前端渲染所需數據
        this.addresses = JSON.parse(JSON.stringify(addresses)) ;
        this.default_address_id = default_address_id ;
    },
    watch:{
        //監聽區域數據據此改變縣市數據
        'form_address.area_id':function (){
            let url = this.api.AreaUrl + '?area_id=' + this.form_address.area_id ;
            axios.get(url ,{
                responseType: 'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    this.cities = response.data.sub_data.subs ;
                } else if (response.data.code === '4101'){
                    location.href = this.api.LoginUrl + '?next=/api/addresses/get/' ;
                } else {
                    console.log(response.data.errmsg) ;
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //監聽縣市數據據此改變區鎮數據
        'form_address.city_id':function (){
            let url = this.api.AreaUrl + '?area_id=' + this.form_address.city_id ;
            axios.get(url ,{
                responseType: 'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    this.districts = response.data.sub_data.subs ;
                } else if (response.data.code === '4101'){
                    location.href = this.api.LoginUrl + '?next=/api/addresses/get/' ;
                } else {
                    console.log(response.data.errmsg) ;
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
    },
    methods:{
        //新增或修改地址表單
        get_area(){
            let url = this.api.AreaUrl ;
            axios.get(url ,{
                responseType: 'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    this.areaes = response.data.area_list ;
                } else if (response.data.code === '4101'){
                    location.href = this.LoginUrl + '?next=/api/addresses/get/' ;
                } else {
                    console.log(response.data.errmsg) ;
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        check_receiver(){
            if (!this.form_address.receiver){
                this.error_receiver = true ;
            } else {
                this.error_receiver = false ;
            }
        },
        check_mobile() {
            let re = /^09[\d]{8}$/ ;
            if (re.test(this.form_address.mobile)){
                this.error_mobile = false ;
            } else {
                this.error_mobile = true ;
            }
        },
        check_email() {
            if (this.form_address.email){
                let re = /^[\w.-]+@[\w-]+(.[\w_-]+)+$/ ;
                if (re.test(this.form_address.email)){
                    this.error_email = false ;
                } else {
                    this.error_email = true ;
                }
            } else {
                this.error_email = false ;
            }
        },
        check_place(){
            if (!this.form_address.place){
                this.error_place = true ;
            } else {
                this.error_place = false ;
            }
        },
    },
})