<template>
    <div>


        <table class="table table-bordered">
            <thead>
            <tr>
                <th v-on:click="Sort(Orders, 'id_order'), Sortrow = !Sortrow">ID</th>
                <th v-on:click="Sort(Orders, 'products_order'), Sortrow = !Sortrow"> Заказ</th>
                <th v-on:click="Sort(Orders, 'delivery_order'), Sortrow = !Sortrow">Доставка</th>
                <th v-on:click="Sort(Orders, 'id_status'), Sortrow = !Sortrow"> Статус </th>

            </tr>
            </thead>
            <tbody>
            <tr v-for="Order in Orders" :key="Order.id_order">
                <td>{{ Order.id_order }}</td>
                <td> <p v-for="position in splitString(Order.products_order, '__')" :key="position"> {{position}}</p>  </td>
                <td :style="{color : (Order.delivery_order == 'Самовывоз')?'green':'red'}">{{ Order.delivery_order }}</td>
                <td><SelectStatusLi :SelectedSatatus="Order.id_status" :IDorder=" Order.id_order"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
    const UpdateOrdersTime = 10000;
    import SelectStatusLi from './SelectStatusLi.vue';
    import {HostPatch} from "@/main";
    //setTimeout(function () { this.fetchData() }.bind(this), 3000);







    export default {
        name: "BannersEditor",
        data() {
            return {
                Orders: null,
                New_Order: null,
                selectedStatus: null,
                Sortrow:null,
                SortState: "id_order",
                active_color: "red",
                LastOrder: null,

            };
        },
        props: {

        },

        methods: {


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
                const res = await fetch(HostPatch+`/get_orders.php`);
                this.Orders = await res.json();
                if (this.Orders != null) {
                    this.Orders.sort((a, b) => Number(b['id_order']) - Number(a['id_order']));
                    this.New_Order = this.Orders[0].id_order;
                    }

                if ((this.LastOrder!=this.New_Order)&&(this.LastOrder!=null)&&(this.New_Order!=null)){

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
        components: { SelectStatusLi }
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