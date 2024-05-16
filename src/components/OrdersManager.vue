<template>
    <div class="manager">
        <HeaderApp :HeaderTitle = "'Менеджер'" />

    </div>

    <div v-show="AddMealval">
        <AddMenu  @add-to-order="AddtoOrder" @cancel-add-to-order="CancelAddtoOrder" :OrderID="IdOrder"/>
    </div>


    <div v-show="!AddMealval">
<div>
    <button class="button" v-on:click="AddOrder()">Создать заказ</button>
<div>

</div>

        <table class="table_add">
            <thead>
            <tr>
                <th v-on:click="Sort(Orders, 'id_order'), Sortrow = !Sortrow">ID</th>
                <th>Дата</th>
                <th>Тип заказа</th>
                <th v-on:click="Sort(Orders, 'products_order'), Sortrow = !Sortrow" width="250px"> Заказ</th>
                <th v-on:click="Sort(Orders, 'id_status'), Sortrow = !Sortrow"> Адрес </th>
                <th v-on:click="Sort(Orders, 'id_status'), Sortrow = !Sortrow"> Телефон </th>
                <th v-on:click="Sort(Orders, 'id_status'), Sortrow = !Sortrow"> Сумма </th>
                <th v-on:click="Sort(Orders, 'delivery_order'), Sortrow = !Sortrow">Доставка</th>
                <th v-on:click="Sort(Orders, 'id_status'), Sortrow = !Sortrow" > Статус </th>
                <th width="40px">Изменить/Удалить</th>

            </tr>
            </thead>
            <tbody>
            <tr v-for="Order in Orders" :key="Order.id_order">
                <td>{{ Order.id_order }}</td>
                <td>{{DatetoText(Order.date_order)}}</td>
                <td>{{ Order.name_tables}}</td>
                <td> <p v-for="position in splitString(Order.products_order, '__')" :key="position"> {{position}}</p>  </td>
                <td>{{ Order.adress_order }}</td>
                <td>{{ Order.tel_order }}</td>
                <td>{{ Order.price_order }}</td>
                <td :style="{color : (Order.delivery_order == 'Самовывоз')?'green':'red'}">{{ Order.delivery_order }}</td>
                <td><SelectStatusLi :SelectedSatatus="Order.id_status" :IDorder=" Order.id_order"/></td>
                <td><button class="button" v-on:click="OpenEditor(Order.id_order, Order.adress_order, Order.tel_order, Order.price_order, Order.delivery_order,
                Order.tables_order, Order.waiters_order )">Изменить</button>
                    <button class="button" v-on:click="DeleteOrder(Order.id_order)">Удалить</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="modalEdit_orders" v-show="EditOrder">

        <section>
            <div class="title_order"><h2>Заказ № {{IdOrder}}</h2></div>
            <div class="propits">


            <label >Адрес доставки
            <input class="input" type="text" name="AdressOrder" size="20" v-model="AdressOrder">
            </label>
            <label >Телефон
            <input class="input" type="text" name="TelOrder" size="20" v-model="TelOrder">
            </label>
            <label>Доставка
            <select class="input"  v-model="DeliveryOrder">
                <option v-bind:key="DeliveryOrder">Доставка</option>
                <option v-bind:key="DeliveryOrder">Самовывоз</option>
            </select>
            </label>
                <label>Стол
                    <select class="input"  v-model="SelTable">
                        <option v-for="Table in Tables" v-bind:key="Table.id_tables" v-bind:value="Table.id_tables">{{Table.name_tables}}</option>
                    </select>
                </label>
                <label>Официант
                    <select class="input"  v-model="SelWaiter">
                        <option v-for="Waiter in Waiters" v-bind:key="Waiter.id" v-bind:value="Waiter.Username">{{Waiter.Username}}</option>

                    </select>
                </label>

            <label>Сумма заказа
            <input class="input" disabled type="text" name="PriceOrder" size="20" v-model="PriceOrder">
            </label>
                <button class="button" @click="AddMealval= true">Добавить</button>
                </div>
            <table class="table table-bordered">
             <thead>
            <tr>
                <th >ID</th>
                <th >Блюдо</th>
                <th >Кол-во</th>
                <th >Цена </th>
                <th >Сумма </th>


            </tr>
            </thead>
            <tr v-for="Body in BodyOrder" :key="Body.id_orders_inside">
                <td>{{ Body.id_meal }}</td>
                <td>{{ Body.name_meal }}</td>
                <td><div>{{Body.qty_orders_inside}}</div>
                <div>
<!--                    <button v-on:click="QtyOrdersPlus(Body.qty_orders_inside, IdOrder)">+</button>-->
<!--                    <button v-on:click="QtyOrdersMinus(Body.qty_orders_inside, IdOrder)">-</button>-->
                    <button v-on:click="((Body.qty_orders_inside) = Number(Body.qty_orders_inside)+1), All_Summ()">+</button>
                    <button v-on ="(Body.qty_orders_inside > 0?{click: () =>((Body.qty_orders_inside) = Number(Body.qty_orders_inside)-1, All_Summ()) }:{click: () =>
                    (Body.qty_orders_inside)=0})">-</button>



                </div>
                </td>
                <td>{{ Body.price_meal }}</td>
               <td>{{ Body.price_meal * Body.qty_orders_inside }}</td>
            </tr>
            </table>



            <div class="buttons_bottom">
            <button class="button" v-on:click="SaveOrder(IdOrder, AdressOrder, TelOrder, DeliveryOrder, PriceOrder, SelTable, SelWaiter, BodyOrder)">Сохранить</button>
            <button class="button" v-on:click="EditOrder = false">Отмена</button>
            </div>
        </section>


    </div>
    </div>

</template>

<script>
  //  const UpdateOrdersTime = Number(60000);
  import HeaderApp from "@/components/HeaderApp";
    import SelectStatusLi from './SelectStatusLi.vue';
    import AddMenu from './AddMenu'
    import {HostPatch} from "@/main";
    //setTimeout(function () { this.fetchData() }.bind(this), 3000);







    export default {
        name: "BannersEditor",


        data() {
            return {

                AddMealval: false,
                Orders: null,
                New_Order: null,
                selectedStatus: null,
                Sortrow:null,
                SortState: "id_order",
                active_color: "red",
                LastOrder: null,
                EditOrder: false,
                IdOrder: null,
                AdressOrder: null,
                TelOrder: null,
                DeliveryOrder: null,
                PriceOrder: null,
                BodyOrder: null,
                qty_orders_inside: 0,
                Tables: null,
                Waiters: null,
                SelTable: null,
                SelWaiter: null


            };
        },
        props: {

        },
        emits:{

        },

        methods: {
            CancelAddtoOrder(){
                this.AddMealval= false;
            },

         async   AddOrder(){
                await fetch(HostPatch+`/EditOrders.php?AddOrder`);
                this.fetchData();
            },


            DatetoText(dateB){
            let yymmdd = dateB.split(' ');
            let  ddmmyy = yymmdd[0].split('-');

                return ddmmyy[2]+'.'+ddmmyy[1]+'.'+ddmmyy[0]+' в: '+yymmdd[1] ;


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
             },


            All_Summ(){
             let summ_order = 0;
                for (let i = 0; i < this.BodyOrder.length; i++) {
                summ_order += this.BodyOrder[i].price_meal * this.BodyOrder[i].qty_orders_inside;
                }

                this.PriceOrder = summ_order;

            },


            async  QtyOrdersPlus(qty_orders_inside, IdOrder){
                await fetch(HostPatch+`/EditOrders.php?plus_orders_inside=`+qty_orders_inside+'&IdOrder='+IdOrder);
             },
            async    QtyOrdersMinus(qty_orders_inside, IdOrder){
                if (qty_orders_inside>0){
                    await fetch(HostPatch+`/EditOrders.php?minus_orders_inside=`+qty_orders_inside+'&IdOrder='+IdOrder);
                } else
                {
                    await fetch(HostPatch+`/EditOrders.php?minus_orders_inside=`+'delete'+'&IdOrder='+IdOrder);
                }
              },

          async  DeleteOrder(IdOrder){
                await fetch(HostPatch+`/EditOrders.php?del_order=`+IdOrder);
                this.fetchData();
            },

            async  SaveOrder(IdOrder, AdressOrder, TelOrder, DeliveryOrder, PriceOrder, Table, Waiter, BodyOrder){
             console.log(Waiter, Table);
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
                    //headers: { "Content-Type": "application/formdata" },
                    //body: JSON.stringify(postData),
                    body: formData
                };
                await fetch(HostPatch+`/EditOrders.php`, requestOptions);
                this.EditOrder = false;
                this.IdOrder = null;
                this.AdressOrder = null;
                this.TelOrder = null;
                this.DeliveryOrder = null;
                this.PriceOrder = null;
                this.fetchData();
            },

            // async  SaveOrder(IdOrder, AdressOrder, TelOrder, DeliveryOrder, PriceOrder, BodyOrder){
            //
            //     await fetch(HostPatch+`/EditOrders.php?save_order=`+IdOrder+'&AdressOrder='+
            //     AdressOrder+'&TelOrder='+TelOrder+'&DeliveryOrder='+DeliveryOrder+'&PriceOrder='+PriceOrder+
            //         '&BodyOrder='+BodyOrder);
            //     this.EditOrder = false;
            //     this.IdOrder = null;
            //     this.AdressOrder = null;
            //     this.TelOrder = null;
            //     this.DeliveryOrder = null;
            //     this.PriceOrder = null;
            //     this.fetchData();
            //
            // },

         async   OpenEditor(id_order, adress_order, tel_order, price_order, id_status, id_table, id_waiter){
                this.EditOrder = true;
                this.IdOrder = id_order;
                this.AdressOrder = adress_order;
                this.TelOrder = tel_order;
                this.DeliveryOrder = id_status;
                this.PriceOrder = price_order;
                this.SelTable = id_table;
                this.SelWaiter = id_waiter;



             const res = await fetch(HostPatch+`/EditOrders.php?id_order=`+this.IdOrder);
             this.BodyOrder = await res.json();

             const res2 = await fetch(HostPatch+`/EditOrders.php?Tables`);
             this.Tables = await res2.json();


             const res3 = await fetch(HostPatch+`/EditOrders.php?Waiters`);
             this.Waiters = await res3.json();



            },

            splitString(stringToSplit, separator) {
            var arrayOfStrings = stringToSplit.split(separator);
            return arrayOfStrings;
    },

            PlaySound () {
                var  audio = new Audio('https://fila09.ru/assets/sounds/kol.mp3');
                audio.play();
            },

            UpdateData() {
                setTimeout(() => {
                    this.fetchData();
                }, 10000);


            },


            async fetchData() {
               
                if (this.Orders != null) {
                this.Orders.sort((a, b) => Number(b['id_order']) - Number(a['id_order']));
                this.LastOrder = this.Orders[0].id_order;
                }
                const res = await fetch(HostPatch+`/EditOrders.php?all`);
                this.Orders = await res.json();
                if (this.Orders != null) {
                    this.Orders.sort((a, b) => Number(b['id_order']) - Number(a['id_order']));
                    this.New_Order = this.Orders[0].id_order;
                    }

                if ((this.LastOrder<this.New_Order)&&(this.LastOrder!=null)&&(this.New_Order!=null)){

                    this.PlaySound ();
                }
                this.Sort(this.Orders, this.SortState);

                this.UpdateData();
            },





            Sort(arr, row){

            if (arr != null) {
                this.SortState = row;

                switch (row) {


                    case ('price_order'):
                    case ('id_order'): {
                        if (this.Sortrow ) {

                            arr.sort((a, b) =>  Number(a[row])- Number(b[row]));
                        }
                        else
                        {

                            arr.sort((a, b) => Number(b[row]) - Number(a[row]));
                        }
                        break;}
                    default:
                        if (this.Sortrow) {

                            return arr.sort((a, b) => a[row].localeCompare(b[row]));
                        } else {

                            return arr.sort((a, b) => b[row].localeCompare(a[row]));
                        }
                }
            }
            },

        },
        mounted() {
           // setInterval();
            this.fetchData();

        },
        components:  {
            SelectStatusLi, AddMenu, HeaderApp
        }
    }


</script>

<style>


</style>