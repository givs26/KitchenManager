<template>
    <div>
        <button class="button" v-on:click="NewUser()">Создать пользователя</button>

        <table class="table_add">
            <thead>
            <tr>
                <th >ID</th>
                <th >Имя</th>
                <th >Пароль</th>
                <th> Редактирование</th>
                <th> Удаление </th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="User in Users" :key="User.id" >
                <td>{{ User.id }}</td>
                <td>{{ User.Username }}</td>
                <td>{{ User.Pass}}</td>
                <td><button class="button" v-bind:class="User.id" v-on:click="EditUser(User.id, User.Username, User.Pass, User.role_users)">Изменить</button></td>
                <td><button v-if="User.id != 1" class="button" v-on:click="DeleteUser(User.id )">Удалить</button></td>
            </tr>
            </tbody>
        </table></div>

    <div class="modalEdit_orders" v-show="EditNewUser">
        <h2>{{CreateOrEdit}}</h2>
        <section>
            <p>Имя пользователя </p>
            <input class="input" type="text" name="UserName" size="50" v-model="UserName">
            <p>Роль</p>
            <select class="input"  v-model="UserRole" >
                <option v-for="Role in Roles" v-bind:key="Role.id" v-bind:value="Role.id">{{Role.role}}</option>

            </select>
            <p>Пароль</p>
            <input class="input" type="text" name="UserPass" size="50" v-model="UserPass">


            <br><br>


            <button class="button" v-on:click="PostData(UserID, UserName, UserPass, UserRole)">{{ButtonApllyNew}}</button>
            <button class="button" v-on:click="EditNewUser = false">Отмена</button>
        </section>
    </div>
</template>

<script>
    import bcrypt from 'bcryptjs';
    import {HostPatch} from "@/main";
    export default {
        name: "UserEditor",
        data() {
            return {
                Users: null,
                UserID : null,
                UserName : null,
                UserPass : null,
                EditNewUser:false,
                UserRole: null,
                Roles: null,


            }
        },
        methods:{
        async    DeleteUser(user_id){
                await fetch(HostPatch + "/EditAdmins.php?DeleteUserId="+user_id);
                this.fetchData();
                },

            GetHash(pass){
                if (pass != null){
                    const soltpass = bcrypt.genSaltSync(10);
                    let passh = bcrypt.hashSync(pass, soltpass);
                    return(passh);
                }
            },


    async PostData(UserID, UserName, UserPass, UserRole) {

        const formData = new FormData();
        formData.append('UserID', UserID)
        formData.append('UserName', UserName)
        formData.append('UserPass', UserPass)
        formData.append('Role', UserRole)
        formData.append('UserPassH', this.GetHash(UserPass))

        const requestOptions = {
            method: "POST",
            body: formData
        };

        await fetch(HostPatch + "/EditAdmins.php", requestOptions);
        this.fetchData();
        this.ButtonApllyNew = "Применить";
        this.UserID = null;
        this.UserName = null;
        this.EditNewUser = false;
    },

    EditUser(UserID, UserName, UserPass, UserRole){
        this.EditNewUser = true;
        this.UserID = UserID;
        this.UserName = UserName;
        this.UserPass = UserPass;
        this.UserRole = UserRole;
        this.ButtonApllyNew = "Изменить"
        this.CreateOrEdit = "Изменение данных"

    },

    NewUser(){
        this.EditNewUser = true;
        this.UserID = "new";
        this.UserName = null;
        this.UserPass = null;
        this.ButtonApllyNew = "Создать"
        this.CreateOrEdit = "Создание пользователя"

    },


    async fetchData() {
        this.Users = null
        let res = await fetch(
            HostPatch+"/EditAdmins.php?all"
        )
        this.Users = await res.json()

        res = await fetch(
            HostPatch+"/EditAdmins.php?Roles"
        )
        this.Roles = await res.json();
        console.log(this.Roles);
    }
    }
    ,

    mounted() {
        this.fetchData()
    }
    }
</script>

<style scoped>

</style>