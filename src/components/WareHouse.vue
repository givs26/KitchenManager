<template>
    <div>
        <div>
            <button class="add_button" style="width: 120px; height:30px;  float: none;" v-show="!AddInput" @click="AddInput=true">Добавить</button>
            <div v-show="AddInput">
            <input type="text" class="input" style="width: 220px; height:30px; margin-left: 5px; font-size: 14pt" placeholder="Название" id="name_ingr" v-model="nameIngr">
            <input type="text" class="input" style="width: 120px; height:30px; margin-left: 5px; font-size: 14pt" placeholder="Вес" id="weight_ingr" v-model="weightIngr">
            <button class="add_button" style="width: 120px; height:30px; float: none; margin-left: 5px"  @click="AddIngredient(nameIngr, weightIngr)">Сохранить</button>
            <button class="add_button" style="width: 120px; height:30px; float: none; margin-left: 5px" @click="AddInput=false" >Отмена</button>
            </div>
        </div>

        <table class="table_add">
            <thead>
            <tr>
                <th> Название</th>
                <th> Вес, г.</th>


            </tr>
            </thead>
            <tbody>
            <tr v-for="Ingredient in Ingredients" v-bind:key="Ingredient.id_ingredients" >
                <td style="font-size: 16pt" > <div @click="ChangeName = true" v-bind:key="Ingredient.id_ingredients" v-show="!ChangeName">{{Ingredient.name_ingredients}}</div>
                    <input type="text" class="input" v-show="ChangeName" style="width: 220px; height:30px; margin-left: 5px; font-size: 14pt" placeholder="Название" id="name_ingr_t" v-model="Ingredient.name_ingredients"
                    @blur="ChangeName = false, SetNameIngr(Ingredient.id_ingredients, Ingredient.name_ingredients)">
                </td>
                <td>

                    <input type="text" class="input" v-show="ChangeWeight" style="width: 220px; height:30px; margin-left: 5px; font-size: 14pt" placeholder="Вес" id="weight_ingr_t" v-model="Ingredient.warehouse_ingredients"
                           @blur="ChangeWeight = false, SetWeightIngr(Ingredient.id_ingredients, Ingredient.warehouse_ingredients)">
                    <div class="pie animate no-round"  @click="ChangeWeight = true" v-show="!ChangeWeight" v-bind:style="{'--p' : Ingredient.warehouse_ingredients/100}" style="--c:orange;"> {{Ingredient.warehouse_ingredients}}</div>
                </td>
                </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
    import {HostPatch} from "@/main";
    export default {

        name: "WareHouse",
        data(){
            return{
                AddInput: false,
                Ingredients: null,
                nameIngr: null,
                weightIngr: null,
                ChangeName: false,
                ChangeWeight: false,
            }
        },

        methods: {

            async SetWeightIngr(id_ingredients,weight_ingredients){
                await fetch(HostPatch + `/EditCards.php?SetWeight=`+id_ingredients+'&Weight='+weight_ingredients);
            },

            async SetNameIngr(id_ingredients,name_ingredients){
                await fetch(HostPatch + `/EditCards.php?SetIngredient=`+id_ingredients+'&Name='+name_ingredients);
                },

            async AddIngredient(nameIngr, weightIngr){
                if (nameIngr!=null){
                 await fetch(HostPatch + `/EditCards.php?AddIngredient=`+nameIngr+'&Weight='+weightIngr);
                this.nameIngr =  null;
                this.weightIngr= null;
                }
    },
            async Get() {
                this.Loading = true;
                this.Ingredients = null;
                let res = await fetch(HostPatch + `/EditCards.php?Ingredients`);
                this.Ingredients = await res.json();
               }

        },
        mounted() {
            this.Get();
        }
    }
</script>

<style scoped>

</style>