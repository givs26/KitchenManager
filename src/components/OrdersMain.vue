<template>
    <div class="kitchen">
        <HeaderApp :HeaderTitle="'Кухня'"/>

    </div>
    <div>
        <div v-show="ShowModal">
            <ModalWindow :src_img="img_prod" v-on:close-modal="closeModal"  :pos_id="modal_id_pos" :Instructions="Instructions" :NameMeal="NameMeal"/>
        </div>



        <table class="table_add" style="width: 100%">
            <thead>
            <tr>
                <th v-on:click="Sort(Orders, 'id_order'), Sortrow = !Sortrow">ID</th>
                <th style="width: 58px"> Дата</th>
                <th v-on:click="Sort(Orders, 'products_order'), Sortrow = !Sortrow"> Заказ</th>
                <th v-on:click="Sort(Orders, 'delivery_order'), Sortrow = !Sortrow">Куда</th>
<!--                <th v-on:click="Sort(Orders, 'id_status'), Sortrow = !Sortrow"> Статус </th>-->

            </tr>
            </thead>
            <tbody>
<!--            v-on:click="ShowImage(pos.pic_meal, pos.id_meal, pos.instructions_meal, pos.name_meal)"-->
            <tr v-for="Order in Orders" :key="Order.id_order"  >
                <td style="font-size: 12px">{{ Order.id_order}} </td>
                <td style="font-size: 12px">{{DatetoText(Order.date_order)}}</td>
                <td style="text-align: right; font-size: 14px"> <div  v-for="pos in Order.positions" :key="pos"><div style="float: left; margin-top: 4px;"
                                                                                                     v-on:click="ShowImage(pos.pic_meal, pos.id_meal, pos.instructions_meal, pos.name_meal), ShowModal=true">
                    {{pos.name_meal}}</div>
<!--                    Цена:{{pos.price_meal}}-->
                 Кол-во:{{pos.qty_orders_inside}}<input type="checkbox" style="margin-left: 30px" id="done"
                 v-bind:checked="(pos.done_orders_inside == 1)?true:false" v-on:click="setPosDone(pos.id_orders_inside, pos.products_orders_inside)"></div>
                </td>
                <td :style="{color : (Order.delivery_order == 'Самовывоз')?'green':'red'}" style="text-wrap: avoid; width: 10px">{{ Order.delivery_order }}</td>
<!--                <td><SelectStatusLi :SelectedSatatus="Order.id_status" :IDorder=" Order.id_order"/></td>-->
            </tr>
            </tbody>
        </table>
        <ul >
            <li v-for="pos in Positions" :key="pos" > {{pos.name_meal}}</li>
        </ul>
        <p>{{Positions}}</p>
    </div>
</template>

<script>
    import HeaderApp from "@/components/HeaderApp";
    const UpdateOrdersTime = 10000;
    // import SelectStatusLi from './SelectStatusLi.vue';
    import ModalWindow from'./ModalWindow.vue'
    import {HostPatch} from "@/main";

    //setTimeout(function () { this.fetchData() }.bind(this), 3000);







    export default {
        name: "BannersEditor",

        components: {
            // SelectStatusLi ,
            HeaderApp,
            ModalWindow,
        },

        data() {
            return {
                ShowModal:false,
                Orders: null,
                New_Order: null,
                selectedStatus: null,
                Sortrow:null,
                SortState: "id_order",
                active_color: "red",
                LastOrder: null,
                Positions: null,
                img_prod:null,
                modal_id_pos: null,
                Instructions:null,
                NameMeal: null,
                RandomOpen:null

            };
        },
        props: {

        },

        methods: {
            closeModal(){
                this.ShowModal = false;
            },
            ShowImage(pic, id_pos, instructions, namemeal){
                this.img_prod = HostPatch+'assets/'+pic;
                this.modal_id_pos = id_pos;
                this.Instructions = instructions;
                this.NameMeal = namemeal;

            },

            DatetoText(dateB){
                let yymmdd = dateB.split(' ');
                let  ddmmyy = yymmdd[0].split('-');
                return ddmmyy[2]+'.'+ddmmyy[1]+'.'+ddmmyy[0]+' в: '+yymmdd[1] ;
            },

         async   setPosDone(id_orders_inside, products_orders_inside){
             await fetch(HostPatch+`/EditOrders.php?setPosDone=`+id_orders_inside+'&id_prod='+products_orders_inside);
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
                }, UpdateOrdersTime);


            },


            async fetchData() {
               
                if (this.Orders != null) {
                this.Orders.sort((a, b) => Number(b['id_order']) - Number(a['id_order']));
                this.LastOrder = this.Orders[0].id_order;
                }
                const res = await fetch(HostPatch+`/EditOrders.php?getPositions`);
                this.Orders = await res.json();
                if (this.Orders != null) {
                    this.Orders.sort((a, b) => Number(b['id_order']) - Number(a['id_order']));
                    this.New_Order = this.Orders[0].id_order;
                    }

                if ((this.LastOrder!=this.New_Order)&&(this.LastOrder!=null)&&(this.New_Order!=null)){

                    this.PlaySound ();
                }
                this.Sort(this.Orders, this.SortState);

               // this.UpdateData();


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

    }


</script>

<style>


    .table {
        margin-left: auto;
        margin-right: auto;
        margin-top: 20px;
        border-radius: 10px;
        background: #D9D9D9;
        font-family: Kaisei HarunoUmi;
        width: 90%;
    }
    .table-td{
        margin:10px;
    }
    .table thead th {
        font-weight: bold;
        text-align: center;
        border: none;
        border-radius: 10px;
        padding: 10px 15px;
        font-size: 20px;
        background:  #8E5508;
        color: #D9D9D9;
    }
    .table tr{

    }
    .table  td {
        font-size: 20px;
        color: #505050;
        text-align: center;
        border-bottom: 1px solid #cccccc;
        border-right: 1px solid #cccccc;
        padding: 10px 15px;
        vertical-align: top;

    }

</style>