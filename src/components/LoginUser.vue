<template>
    <div class="login-form" style="height: 140px; width: 200px ; padding: 10px;">
        <p>Тестовые учетные данные:</p>
        <p>Администратор: admin/123 </p>
        <p>Кухня: kitchen/123 </p>
        <p>Официант: waiter/123 </p>
    </div>
    <div class="login-form">
        <p class="login-title">Авторизация</p>

        <label class="login-label">Логин:</label>
        <div  > <input type="text" class="login-input" v-model="User" > </div>
        <label class="login-label">Пароль:</label>
        <div > <input type="password" class="login-input" v-model="Pass" v-on:keyup.enter="AuthUser"> </div>
            <div>
                <button class="login-button" @click="AuthUser">Вход</button> </div>
        <p class="login-error" >{{ErrorPass}}</p>
    </div>

</template>

<script>
    import bcrypt from 'bcryptjs';
    import {HostPatch} from "@/main";

    export default {
        name: "LoginUser",
        emit:{

        },
        data(){
            return{
                User: null,
                Pass: null,
                PassH: null,
                ErrorPass: '',


            }
        },
        methods:{
            GetHash(user, pass){
                if (pass != null){
                const soltpass = bcrypt.genSaltSync(10);
                const soltuser = bcrypt.genSaltSync(10);
                let passh = bcrypt.hashSync(pass, soltpass);
                let userh = bcrypt.hashSync(user, soltuser);
                const userdata = {
                    passh : passh,
                    userh : userh
                }
                return(userdata);
                }
            },

           async AuthUser(){
                // if (localStorage.getItem("user")!=null){
                //     this.User = localStorage.getItem("user");
                //     console.log('Получили логин из storage', this.User);
                // }
               await this.GetPassH();
               let authU = false;
               // console.log('Получили passh из storage',  this.PassH );
               //
               // if(localStorage.getItem("PassH")!=null && localStorage.getItem("user")!=null){
               //     if (localStorage.getItem("PassH") == this.PassH[0].hashPass){
               //         authU = true;
               //     }
               // }


               if(this.PassH==''){ this.ErrorPass = 'Комбинация не верна'; }
                if (this.Pass!=null && this.User!=null && this.PassH!=''){
                    if(authU!=true){
                    authU =  await  bcrypt.compare(this.Pass, this.PassH[0].hashPass);}



               //  console.log(this.PassH);
               // console.log(this.Pass);




             if (authU) {
                 let Role = this.PassH[0].role_users.toString();
                 localStorage.setItem("user", this.User);
                 localStorage.setItem("PassH", this.PassH[0].hashPass);
                 localStorage.setItem("Auth", true);
                 this.$emit('SetFirstOpen', authU,Role);
             } else{
                 this.ErrorPass = 'Комбинация не верна';
             }
            }
                },
            async GetPassH(){
                let res = await fetch(
                    HostPatch+"/EditAdmins.php?UserNameAUTH="+this.User
                )
                this.PassH = await res.json();

            },
            async getUserData() {
                this.User = localStorage.getItem("user");
                if (localStorage.getItem("user") != null && localStorage.getItem("PassH") != null) {
                    this.User = localStorage.getItem("user");
                    console.log('Получили логин из storage', this.User);
                    await this.GetPassH();
                    console.log('Получили passh из SQL', this.PassH);
                    if (localStorage.getItem("PassH") == this.PassH[0].hashPass) {
                        let Role = this.PassH[0].role_users.toString();

                        let authU = true;
                        this.$emit('SetFirstOpen', authU, Role);
                    }
                }
            }
        },
        mounted () {
            this.getUserData();
        }
    }
</script>

<style scoped>
    .login-form{
        margin-left: auto;
        margin-right: auto;
        margin-top: 15%;
        width: 320px;
        height: 287px;
        background: #DDE7E9;
        border: 2px solid #5D636F;
        border-radius: 12px;
        box-shadow: 5px 5px 2px 1px rgba(0, 0, 0, .1);
    }
    .login-title{
        color: #F18230;
        font-size: 16pt;
        margin-left: 15px;
        margin-top: 15px;
        font-family: "Roboto";
    }
    .login-input{
        color: #F18230;
        margin-top: 2px;
        margin-left: 15px;
        width: 269px;
        height: 42px;
        border: 0px solid white;
        border-radius: 7px;
        font-family: "Roboto";
        font-size: 16pt;
    }
    .login-label{
        margin-left: 15px;
        margin-top: 5px;
        margin-bottom: 2px;
        font-size: 10pt;
        color: #F18230;
        background: none;
        font-family: "Roboto";
    }

    .login-error{
        margin-left: 15px;
        margin-top: 1px;
        margin-bottom: 1px;
        font-size: 8pt;
        color: black;
        background: none;
        font-family: "Roboto";
    }
    .login-button{
        display: block;
        margin-left: auto;
        margin-right: auto;
        margin-top: 10px;
        background: #F18230;
        width: 145px;
        height: 37px;
        border-radius: 7px;
        border: none;
        box-shadow: inset 0px 0px 10px rgba(0,0,0,0.5);
        color: white;
    }


    .login-button:after {
        transform: translateY(4px);
    }

    .login-button:active {
        background-color: #f6791c;
        transform: translateY(2px);
    }


</style>