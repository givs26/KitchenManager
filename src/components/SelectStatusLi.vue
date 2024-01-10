<template>
<div >
<select class="input_select"    id="Select" v-model="selStatus"   @change="SetStatus(idOrder, selStatus)" >
    <option v-for="Status in Statuses"  :style="{color: color_Stat = Status.color_status}" v-bind:key="Status.id_status"  v-bind:value="Status.id_status"  >{{ Status.name_status }} </option>
</select>
</div>
</template>


<script>
    import {HostPatch} from "@/main";
 export default {
        name: "SelectStatusLi", 
        data(){
            return{
                Statuses: null,
                selStatus: this.SelectedSatatus,
                idOrder: this.IDorder,
                color_Stat: null,
                Status:null
                     } 
        },
        props:['SelectedSatatus', 'IDorder'], 
        
        methods:{
            // SetColorStutus(selStatus){
            //     console.log(selStatus);
            //     selStatus = 3;
            //
            //     for (this.Status in this.Statuses){
            //             if (this.Status.id_status == selStatus) {
            //                 console.log('color: '+this.Status.color_status);
            //                 return 'color: '+this.Status.color_status;
            //             }
            //     }
            //     //console.log(this.Statuses.id_status = selStatus);
            //            // return this.Statuses.id_status = selStatus;
            //     return 'red';
            // },

            SetStatus(Order, Status) {

                        const formData = new FormData();
                        formData.append('Order', Order)
                        formData.append('Status', Status)
                        const requestOptions = {
                            method: "POST",
                            body: formData
                        };

                        fetch(HostPatch+"/set_status.php", requestOptions);

            },
            async fetchData() {
                this.Statuses = null
                const res = await fetch(
                    HostPatch+`/get_statuses.php`
                )
                this.Statuses = await res.json();
                
            },
           
           

        },
        mounted() {
            this.fetchData();
        }
    }


</script>

<style>

    .input_select{

        color: #505050;
        text-align: center;
        border: none;
        font-size: 18px;
        vertical-align: center;
        background: #D9D9D9;
    }
</style>