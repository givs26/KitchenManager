<template>

 <LoginUser @SetFirstOpen="SetFO" v-if="!LoginUser"/>
<div id="buttons"  >
 <button class="button" v-on:click="Switcher= 'OrdersMain'" v-if="FirstOpen">
  Кухня
 </button>
 <button class="button" v-on:click="Switcher='OrdersManager'" v-if="FirstOpen">
  Менеджер/Администратор
 </button>
 <button class="button" v-on:click="Switcher='WaitersTables'" v-if="FirstOpen">
  Официант
 </button>
 <button class="button" v-on:click="Switcher='Cards'" v-if="FirstOpen">
  Карты
 </button>
 <button class="button" v-on:click="Switcher='WareHouse'" v-if="FirstOpen">
  Склад ингредиентов
 </button>
  <button class="button" v-on:click="Switcher='UserEditor'" v-if="FirstOpen">
  Пользователи
 </button>
 <button class="button" v-on:click="Logout" v-if="LoginUser">
  Выйти
 </button>
</div>
<!-- <div v-for="Component in Components" v-bind:key="Component"><{{Component.name_components}}/></div>-->
<!---->

 <OrdersMain v-if="Switcher == 'OrdersMain'"/>
 <OrdersManager v-if="Switcher == 'OrdersManager'" />
 <WaitersTables v-if="Switcher == 'WaitersTables'" />
 <CardsEditor v-if="Switcher == 'Cards'" />
 <WareHouse v-if="Switcher == 'WareHouse'" />
 <UserEditor v-if="Switcher == 'UserEditor'" />

<!-- <CardProduct/>-->

</template>

<script>

 import {HostPatch} from "@/main";
import OrdersMain from "@/components/OrdersMain";
import OrdersManager from "@/components/OrdersManager";
//import AddMenu from "@/components/AddMenu";
// import CardProduct from "@/components/CardProduct"
import WaitersTables from './components/WaitersTables';
import CardsEditor from './components/CardsEditor';
import WareHouse from './components/WareHouse';
import LoginUser from './components/LoginUser';
import UserEditor from './components/UserEditor';

export default {
  name: 'App',
    data(){
      return{
       Switcher: null,
       FirstOpen: false,
       UserRole: null,
       Components: null,
       LoginUser: false
      }
    },
  components: {
      OrdersMain,
      CardsEditor,
      OrdersManager,
      WaitersTables,
      WareHouse,
      LoginUser,
      UserEditor,


      // CardProduct,
  },
      methods: {
       SetFO(FOData, Role) {
        this.LoginUser = FOData;
        this.UserRole = Role;
        this.GetComponentsForRole(this.UserRole);
       }

       ,

       async GetComponentsForRole(role) {
        let res = await fetch(
                HostPatch + "/EditAdmins.php?ComponentsForRole=" + role
        )
        this.Components = await res.json()
        console.log(this.Components)
        if (this.Components.length == 1){
         this.Switcher = this.Components[0].name_components;
        this.LoginUser = true;
        } else{
         this.FirstOpen = true;
        }
       },
       Logout(){
        this.LoginUser = false;
        this.FirstOpen = false;
        this.Switcher =  null,
        this.UserRole=null,
        this.Components=null;
        localStorage.removeItem("PassH");
        localStorage.removeItem("Auth");
       }
      }
}
</script>

<style>
#app {

}
</style>
