<template>
    <div>
        <label style="width: 100%; margin-right: 5%;">Стол
            <select class="input"  v-model="SelTable" v-on:change="getTableOrder(SelTable)">
                <option v-for="Table in Tables" v-bind:key="Table.id_tables" v-bind:value="Table.id_tables">{{Table.name_tables}}</option>
            </select>


            <button class="add_button" v-bind:disabled="Close_button" style="margin-left: 10px; height: 25px; width: 100px" @click="CloseTable(SelTable)">Закрыть</button>
            <button class="add_button" v-bind:disabled="Open_button" style="margin-left: 10px; height: 25px; width: 100px" @click="OpenTable(SelTable)">Открыть</button>


        </label>
        <button class="add_button" v-bind:disabled="Close_button" style="margin-left: 40px; margin-top: 5px" @click="AddMealval= true">Добавить в заказ</button>
        <label class="add_button" style="margin-left: 5px; float:none;">Сумма стола: {{PriceOrder}}</label>
    </div>
    <table class="table_add" style="width: 100%">
        <thead>
        <tr>
<!--            <th >ID</th>-->
            <th >Блюдо</th>
            <th>Готов</th>
            <th >Кол-во</th>
            <th>Курс</th>
            <th>Отдано</th>
            <th >Цена </th>
            <th >Сумма </th>


        </tr>
        </thead>
        <tr v-for="Body in BodyOrder" :key="Body.id_orders_inside">
<!--            <td>{{ Body.id_meal }}</td>-->
            <td style="width: 50%">{{ Body.name_meal }}</td>
            <td><input type="checkbox" style="margin-left: 30px; " id="done"
                 disabled    v-bind:checked="(Body.done_orders_inside == 1)?true:false" ></td>
            <td><div>{{Body.qty_orders_inside}}
<!--                    <button v-on:click="((Body.qty_orders_inside) = Number(Body.qty_orders_inside)+1), All_Summ()">+</button>-->
<!--                    <button v-on ="(Body.qty_orders_inside > 0?{click: () =>((Body.qty_orders_inside) = Number(Body.qty_orders_inside)-1, All_Summ()) }:{click: () =>-->
<!--                    (Body.qty_orders_inside)=0})">-</button>-->



                </div>
            </td>
            <td>
                <select class="add_button" style="width: 50px" v-model="Body.kurs_orders_inside"   @change="SetKurs(Body.id_orders_inside, Body.kurs_orders_inside)">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
            </select></td>
            <td> <input type="checkbox" v-show="(Body.done_orders_inside == 1)?true:false" style="margin-left: 30px; " id="done" v-on:change="SetGiven(Body.id_orders_inside)"
                        v-bind:checked="(Body.given_orders_inside == 1)?true:false" ></td>
            <td>{{ Body.price_meal }}</td>
            <td>{{ Body.price_meal * Body.qty_orders_inside }}</td>
        </tr>
    </table>


    <div>

        <div v-show="AddMealval">
            <AddMenu  @add-to-order="AddtoOrder" @cancel-add-to-order="CancelAddtoOrder" :OrderID="OrderID"/>
        </div>

<!--<AddMenu :OrderID = "this.Order[0].id_order"/>-->
    </div>
</template>


<script>
    import AddMenu from './AddMenu';
    import {HostPatch} from "@/main";

    export default {
        name: "WaitersTables",
        data(){
            return{
                      Tables: null,
                      Order: null,
                      OrderID:0,
                      Seltable: null,
                      IDOrder:null,
                      Open_button: false,
                      Close_button: false,
                      BodyOrder: null,
                      AddMealval: false,
                      PriceOrder:null,
                      Waiter:1,


            }
        },
        components: {
           AddMenu
        },
        methods:{


            async  SetGiven(id_orders_inside){

                await fetch(HostPatch+`/EditOrders.php?SetGiven=`+id_orders_inside);
            },

            SetButtons(){
                if (this.Seltable == null){
                    this.Close_button = true;
                    this.Open_button = true;
                }
            },


          async  SetKurs(id_orders_inside, selKurs){
                await fetch(HostPatch+`/EditOrders.php?setKurs=`+selKurs+'&id_orders_inside='+id_orders_inside);
                },

            All_Summ(){
               if (this.BodyOrder !=null){
                let summ_order = 0;
                for (let i = 0; i < this.BodyOrder.length; i++) {
                    summ_order += this.BodyOrder[i].price_meal * this.BodyOrder[i].qty_orders_inside;
                }

                this.PriceOrder = summ_order;}

            },

            async  SaveOrder(IdOrder, AdressOrder, TelOrder, DeliveryOrder, PriceOrder, Table, Waiter, BodyOrder){

                const formData = new FormData();
                formData.append('Action', 'SaveOrder')
                formData.append('IdOrder', IdOrder)
                formData.append('AdressOrder', AdressOrder)
                formData.append('TelOrder', TelOrder)
                formData.append('DeliveryOrder', DeliveryOrder)
                formData.append('PriceOrder', PriceOrder)
                formData.append('Table', Table)
                formData.append('Waiter', Waiter)
                formData.append('BodyOrder', JSON.stringify(BodyOrder))


                const requestOptions = {
                    method: "POST",
                    body: formData
                };
                await fetch(HostPatch+`/EditOrders.php`, requestOptions);

            },

            CancelAddtoOrder(){
                this.AddMealval= false;
            },

            async   AddtoOrder(MealstoOrder){

                for(let i=0; i< MealstoOrder.length; i++) {
                    this.BodyOrder.push({
                        id_orders: MealstoOrder[i].id_orders,
                        name_meal: MealstoOrder[i].name_meal,
                        products_orders_inside: MealstoOrder[i].products_orders_inside,
                        id_meal: MealstoOrder[i].products_orders_inside,
                        qty_orders_inside: MealstoOrder[i].qty_orders_inside,
                        price_meal: MealstoOrder[i].price_meal
                    });
                }
                this.AddMealval= false;
                this.All_Summ();
                this.SaveOrder(this.OrderID, this.Order[0].adress_order, this.Order[0].tel_order,  this.Order[0].delivery_order, this.PriceOrder,  this.Order[0].tables_order,  this.Order[0].waiters_order, this.BodyOrder);
                this.getTables();
                },

            async  CloseTable(Table){
                await fetch(HostPatch+`/EditOrders.php?CloseTable=`+Table);
                this.getTableOrder(Table);

            },

            async  OpenTable(Table){
                let user;
                user = localStorage.getItem("user");


            console.log(Table);
           // const res = await fetch(HostPatch+`/EditOrders.php?OpenTable=`+Table+'&Waiter='+this.Waiter);
            const res = await fetch(HostPatch+`/EditOrders.php?OpenTable=`+Table+'&Waiter='+user);
            this.IDOrder = await res.json();
            console.log(this.IDOrder);
            this.getTableOrder(Table);
            },

         async getTableOrder(Table){
                 const res = await fetch(HostPatch+`/EditOrders.php?TableOrder=`+Table);
                 this.Order = await res.json();

                 if (this.Order.length == 0){
                     this.Open_button = false;
                     this.Close_button = true;
                     this.BodyOrder = null;
                     this.PriceOrder = null;
                 } else {

                     this.Open_button = true;
                     this.Close_button = false;
                     this.OrderID = this.Order[0].id_order;
                     const res = await fetch(HostPatch+`/EditOrders.php?id_order=`+this.OrderID);
                     this.BodyOrder = await res.json();
                     this.All_Summ();
                 }


         },

         async   getTables(){
                const res = await fetch(HostPatch+`/EditOrders.php?Tables`);
                this.Tables = await res.json();

            }
        },
        mounted() {
            this.SetButtons();
            this.getTables();
        },
    }
</script>

<style scoped>

</style>