var vm = new Vue({
    el: '#app',
    delimiters: ['[[', ']]'],
    data: {
        //user_id: sessionStorage.user_id || localStorage.user_id,
        //token: sessionStorage.token || localStorage.token,
        //username: getCookie('username'),
        username: '',
        mobile: '',
        email: '',
        email_active: '',

        set_email: false,
        email_error: false,

        send_email_btn_disabled: false,
        send_email_tip: '重新发送验证邮件',
        histories: []
    },
    mounted(){
        //
        this.email_active = (this.email_active == 'True') ? true : false;
        //
        this.set_email = (this.email == '') ? true : false;
        //
        //this.browse_histories();
    },
    methods: {
        // 退出
        logout: function(){
            sessionStorage.clear();
            localStorage.clear();
            location.href = '/login.html';
        },
        // 保存email
        save_email(){
            // 檢查email格式
            var re = /^\w+((-\w+)|(\.\w+)|(\+\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
            if(re.test(this.email)) {
                this.email_error = false;
            } else {
                this.email_error = true;
                return;
            }
            var url = '/emails/';
            //非get請求在後端進行csrf認證
            axios.put(url , {
                email: this.email
                }, {
                    headers: {
                        'X-CSRFTOKEN': getCookie('csrftoken')
                    },
                    responseType: 'json'
                })
                .then(response => {
                    if (response.data.code == '0'){
                        this.set_email = false;
                        this.send_email_btn_disabled = true;
                        this.send_email_tip = '已发送验证邮件';
                    } else if (response.data.code == '4101'){
                        location.href = '/login/?next=/info/';
                    } else{
                        console.log(response);
                    }
                })
                .catch(error => {
                    console.log(error.response);
                });
        },
    }
});