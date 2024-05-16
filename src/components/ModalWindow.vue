<template >

    <div  class="modalEdit_orders">
         <div><button class="close_btn" v-on:click="CloseWindow">&times;</button></div>
    <div>

    <div class="card-product-title">{{NameMeal}}</div>
        <div class="div-img">
    <img class="card-product-img-kitchen" v-bind:src="src_img" height="350px">
            <div class="ingredients">Игредиенты


                <table class="table_add">
                    <thead>
                    <tr>
                        <th> Название</th>
                        <th> Вес, г.</th>


                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="Ingredient in Ingredients" v-bind:key="Ingredient" v-cloak>
                        <td>{{Ingredient.name_ingredients}}</td>
                        <td>{{Ingredient.weight_ingredients}}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="ingredients tech_card">Технологическая карта</div>
            <div class="ingredients" style="width: 90%" >{{Instructions}}
            </div>
        </div>
    </div>
</div>


</template>

<script>
    import {HostPatch} from "@/main";
    export default {
        name: "ModalWindow",
        data(){
            return{
                count: 1,
                Showed: null,
                Ingredients: null,
                loadALL: true,
                }

        },
        watch:{
          src_img(old_img, new_img){
               if (old_img != new_img){

                   this.GetIngredients(this.pos_id);
              }
          }
        },

        props:{
            pos_id: null,
            src_img:null,
            NameMeal: null,
            Instructions:null,
            ShowMod: null,
        },
        methods:{
            async GetIngredients(pos_id){
                this.Ingredients=null;
               const res =  await fetch(HostPatch+`/EditOrders.php?MealIngredients=`+pos_id);
                this.Ingredients =  await res.json();
                this.count = this.Ingredients.length;
                this.Showed= true;
    },
            CloseWindow(){

               this.$emit('close-modal');

            },

        },
        mounted() {
            this.GetIngredients(this.pos_id);
        }

    }
</script>

<style scoped>

</style>