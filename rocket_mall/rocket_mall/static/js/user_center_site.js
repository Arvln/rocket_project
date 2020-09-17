let vm = new Vue({
    el: '#app',
    delimiters: ['[[' , ']]' ],
    data:{
        //cookie訊息
        username: getCookie('username') ,
        //新增或修改地址表單
        form_address: {
           title: '' ,
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
        address_limit: 20 ,
        add_title: '' ,
        input_title: '' ,

        //提示訊息
        default_receiver: '姓名' ,
        default_mobile: '手機號碼' ,
        default_email: 'Email' ,
        default_place: '樓層、街/路...' ,
        error_receiver: false ,
        error_mobile: false ,
        error_email: false ,
        error_place: false ,

        //表單邏輯參數
        is_show_edit: false ,
        is_show_delete: false ,
        editing_address_index: '' ,
        delete_address_index: '' ,
        edit_title_index: '' ,
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
        get_area() {
            let url = this.api.AreaUrl;
            axios.get(url, {
                responseType: 'json',
            }).then(response => {
                if (response.data.code === '0') {
                    this.areaes = response.data.area_list;
                } else if (response.data.code === '4101') {
                    location.href = this.LoginUrl + '?next=/api/addresses/get/';
                } else {
                    console.log(response.data.errmsg);
                }
            }).catch(error => {
                console.log(error.response);
            })
        },
        check_receiver() {
            if (!this.form_address.receiver) {
                this.error_receiver = true;
            } else {
                this.error_receiver = false;
            }
        },
        check_mobile() {
            let re = /^09[\d]{8}$/;
            if (re.test(this.form_address.mobile)) {
                this.error_mobile = false;
            } else {
                this.error_mobile = true;
            }
        },
        check_email() {
            if (this.form_address.email) {
                let re = /^[\w.-]+@[\w-]+(.[\w_-]+)+$/;
                if (re.test(this.form_address.email)) {
                    this.error_email = false;
                } else {
                    this.error_email = true;
                }
            } else {
                this.error_email = false;
            }
        },
        check_place() {
            if (!this.form_address.place) {
                this.error_place = true;
            } else {
                this.error_place = false;
            }
        },
        //展示新增表單彈窗時
        show_add_site() {
            if (this.addresses.length > this.address_limit ){
                alert('新增地址數量已達上限') ;
            } else {
                this.is_show_edit = true;
                this.clear_all_errors();
                this.form_address.title = '';
                this.form_address.receiver = '';
                this.form_address.mobile = '';
                this.form_address.email = '';
                this.form_address.area_id = '';
                this.form_address.city_id = '';
                this.form_address.district_id = '';
                this.form_address.place = '';
                this.add_title = '新 增';
            }
        },
        //清空所有錯誤訊息
        clear_all_errors() {
            this.error_receiver = false;
            this.error_mobile = false;
            this.error_email = false;
            this.error_place = false;
        },
        //展示修改表單彈窗時
        show_edit_site(index) {
            this.is_show_edit = true;
            this.editing_address_index = index.toString();
            this.form_address = JSON.parse(JSON.stringify(this.addresses[index]));
            this.add_title = '修 改';
        },
        //新增地址
        save_address() {
            this.check_receiver();
            this.check_mobile();
            this.check_email();
            this.check_place();
            if (this.error_receiver === true || this.error_mobile === true || this.error_email === true || this.error_place === true) {
                window.event.returnValue = false;
            } else {
                //默認標題是收貨人姓名
               this.form_address.title = this.form_address.receiver ;
               if (this.editing_address_index === ''){
                   let url = this.api.AddressUrl ;
                   axios.post(url ,this.form_address ,{
                       headers: {
                           'X-CSRFToken':getCookie('csrftoken') ,
                       },
                       responseType: 'json' ,
                   }).then(response=>{
                       if (response.data.code === '0'){
                           this.addresses.splice(0 ,0 ,response.data.address ) ;
                           this.is_show_edit = false ;
                       } else if (response.data.code === '4101'){
                           location.href = this.api.LoginUrl + '?next=/api/addresses/get/' ;
                       } else {
                           console.log(response.data.errmsg) ;
                       }
                   }).catch(error=>{
                       console.log(error.response) ;
                   })
               } else {
                   // 修改地址
                    let url = this.api.ModifyRemoveAddressUrl + this.addresses[this.editing_address_index].id + '/' ;
                    axios.put(url ,this.form_address ,{
                        headers:{
                            'X-CSRFToken':getCookie('csrftoken')
                        },
                        responseType: 'json',
                    }).then(response=>{
                        if (response.data.code === '0'){
                            this.addresses[this.editing_address_index] = response.data.address ;
                            this.is_show_edit = false ;
                        } else if (response.data.code === '4101'){
                            location.href = this.api.LoginUrl + '?next=/api/addresses/get/addresses/get/' ;
                        } else {
                            console.log(response.data.errmsg) ;
                        }
                    }).catch(error=>{
                        console.log(error.response) ;
                    })
               }
            }
        },
        //設為默認
        set_default(index){
           let url = this.api.DefaultAddressUrl + this.addresses[index].id + '/' ;
           axios.put(url ,{} ,{
               headers: {
                   'X-CSRFToken': getCookie('csrftoken') ,
               },
               responseType: 'json' ,
           }).then(response=>{
               if (response.data.code === '0'){
                   this.default_address_id = this.addresses[index].id ;
               } else if (response.data.code === '4101'){
                   location.href = this.api.LoginUrl + '?next=/api/addresses/get/' ;
               } else {
                   console.log(response.data.errmsg) ;
               }
           }).catch(error=>{
               console.log(error.response) ;
           })
        },
        //展示確認刪除彈框時
        show_delete_site(index){
            this.is_show_delete = true ;
            this.delete_address_index = index ;
        },
        //邏輯刪除地址
        delete_address(){
            let url = this.api.ModifyRemoveAddressUrl + this.addresses[this.delete_address_index].id + '/' ;
            axios.delete(url ,{
                headers: {
                    'X-CSRFToken': getCookie('csrftoken') ,
                },
                responseType: 'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    this.addresses.splice(this.delete_address_index ,1 ) ;
                    this.is_show_delete = false ;
                } else if (response.data.code === '4101'){
                    location.href = this.api.LoginUrl + '?next=/api/addresses/get/' ;
                } else {
                    console.log(response.data.errmsg) ;
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
        //取出用戶地址標題
        show_edit_title(index){
           this.edit_title_index = index ;
        },
        //取消設置用戶地址標題
        cancel_title(){
           this.edit_title_index = '' ;
           this.input_title = '' ;
        },
        //保存用戶地址標題
        save_title(){
            let url = this.api.AddressTitleUrl + this.addresses[this.edit_title_index].id + '/' ;
            axios.put(url ,{
                'title': this.input_title
            } ,{
                headers: {
                    'X-CSRFToken': getCookie('csrftoken') ,
                },
                responseType: 'json' ,
            }).then(response=>{
                if (response.data.code === '0'){
                    this.addresses[this.edit_title_index].title = this.input_title ;
                    this.cancel_title() ;
                } else if (response.data.code === '4101'){
                    location.href = this.api.LoginUrl + '?next=/api/addresses/get/' ;
                } else {
                    console.log(response.data.errmsg) ;
                }
            }).catch(error=>{
                console.log(error.response) ;
            })
        },
    }
})