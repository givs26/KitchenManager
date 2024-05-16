<template>
    <div>
        <table class="table_add">
            <thead>
            <tr>
                <th>ID</th>
                <th>Название</th>
                <th> Кол-во </th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="meal in AddMeals" :key="meal">
                <td>{{meal.products_orders_inside}}</td>
                <td> {{ meal.name_meal }}  </td>
                <td>
                    <button v-on ="(meal.qty_orders_inside > 0?{click: () =>((meal.qty_orders_inside) = Number(meal.qty_orders_inside)-1) }:{click: () =>
                    (meal.qty_orders_inside)=0})">-</button>
                    {{ meal.qty_orders_inside }}
                    <button v-on:click="((meal.qty_orders_inside) = Number(meal.qty_orders_inside)+1)">+</button>
                </td>

            </tr>
            </tbody>
        </table>
    </div>
    <div class="options">
        <select class="input_qty" style="height: 18px; width: 150px"    id="Select_group" v-model="Filter_val"  v-on:change="Filter() " >
            <option selected>Все</option>
            <option v-for="Group in Groups" v-bind:key="Group.id_group"> {{Group.name_group}}  </option>
        </select>
        <button class="add_button" style="height: 25px; width: 100px"  @click="this.$emit('cancel-add-to-order'), (AddMeals != null)?AddMeals.length=0:AddMeals = null">Отмена</button>
        <button class="add_button" style="height: 25px; width: 100px"  @click="this.$emit('add-to-order', AddMeals), AddMeals.length=0">Добавить</button>
    </div>
   <div class="cards_line">
       <CardProduct v-for="Meal in FilteredMenu" v-bind:key="Meal.id_meal" @add-meal-to-order="AddMealtoOrder"  :ProductID="Meal.id_meal" :ProductName = "Meal.name_meal" :ProductWeight="Meal.weight_meal"
       :ProductPrice="Meal.price_meal" :ProductImage="'https://fila09.ru/assets/'+Meal.pic_meal" />

   </div>
</template>

<script>
    import CardProduct from "@/components/CardProduct"
    import {HostPatch} from "@/main";

    export default {
        name: "AddMenu",
        components: {
            CardProduct
        },
        props:{
            OrderID: null,
        },
        data() {
        return {
            Menu: null,
            FilteredMenu : null,
            Groups:null,
            Filter_val: null,
            AddMeals: new Proxy ({}, {}),
            body : []

        };
    },
        methods:{



            AddMealtoOrder(ProductID, ProductQty, ProductName, ProductPrice){
                if(ProductQty == null) {ProductQty =1}
                if(ProductQty != null && ProductQty != 0) {

                this.body.push({id_orders:this.OrderID, name_meal:ProductName , products_orders_inside:ProductID, qty_orders_inside:ProductQty, price_meal:ProductPrice});
                this.AddMeals = new Proxy (this.body, {});
            }
                },


            Filter(){
                console.log(this.Filter_val);
                if(this.Filter_val == 'Все') {this.FilteredMenu = this.Menu; } else {
                this.FilteredMenu =   this.Menu.filter((meal) => (meal.name_group) === this.Filter_val);
               }
            },

            async fetchData() {
                const Meals = await fetch(HostPatch+`/EditOrders.php?Meals`);
                this.Menu = await Meals.json();
                this.FilteredMenu = this.Menu;
                const Groups = await fetch(HostPatch+`/EditOrders.php?Groups`);
                this.Groups = await Groups.json();


            },
        },
        mounted() {

            this.fetchData();

        }
    }
</script>

<style scoped>

</style>