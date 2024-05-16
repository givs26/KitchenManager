<template>
    <div class="spin" v-if="Loading" >

    </div>

    <div class="cards_line" v-show="!Loading">
        <div class="card-product" v-for="Meal in Meals" v-bind:key="Meal.id_meal" >

            <div class="card-product-title">{{Meal.name_meal}}</div>

            <div class="div-img">
                <img class="card-product-img" v-bind:src="HostPatch+'assets/'+Meal.pic_meal">
            </div>
            <div class="card-product-descr">
                <div class="card-product-descr-title"><div class="weight">Вес: {{Meal.weight_meal}}</div></div>
                <div class="card-product-descr-title"><div class="price">Цена: {{Meal.price_meal}}</div></div>
            </div>
            <div class="input-buttons">
               <button class="add_button" style="margin-left: 10px; margin-right: 23px;"  @click="ShowModal = true, GetItem(Meal.id_meal)">Редактировать</button>
            </div>
    </div>
    </div>




<!--    Модальное окно-->
    <div  class="modalEdit_orders " style="width: 90%;"  v-show="ShowModal">


        <div style=""><button class="close_btn" v-on:click="ShowModal = false">&times;</button>
            <button class="add_button" style="width: 120px; height:30px;  margin-right: 15px; margin-bottom: 50px"
                    @click="SaveCardMeal(Id_meal ,Name_meal, GroupMeal, Weight_meal, Price_meal, Instructions_meal, Ingredients_meal)">Сохранить</button>
        </div>
<div >
        <div class="div-img" style="" >
            <img class="card-product-img" id="card-product" style="margin-left:15px ; width: 90%;  height: 350px " v-bind:src="HostPatch+'assets/'+Img_meal">
            <label class="input-file add_button" style=" position: absolute; left: 38%; top: 400px"> Загрузить
                <input class="" type="file"  name="File" id="File" @change="uploadImage" />

            </label>

        </div>

        <div style="width: 100%"><input  type="text" class="input_ce" placeholder="Название" id="Name_meal" v-model="Name_meal"></div>
        <div ><input  type="text" class="input_ce" placeholder="Вес" id="Weight_meal" v-model="Weight_meal"></div>
        <div ><input  type="text" class="input_ce" placeholder="Цена" id="Price_meal" v-model="Price_meal"></div>
        <div ><textarea style="height: 250px" type="text" placeholder="Технологическая карта" class="input_ce" id="Instructions_meal" v-model="Instructions_meal"> </textarea></div>
</div>

        <div  >

            <select  class="input_ce" style="width: 90%; margin-left: 20px"   v-model="GroupMeal">
                <option v-for="Group in Groups" v-bind:key="Group.id_group" v-bind:value="Group.id_group">{{Group.name_group}}</option>
            </select>
            <table class="table_add">
                <thead>
                <tr>
                    <th> Название</th>
                    <th> Вес, г.</th>
                    <th> - </th>

                </tr>
                </thead>
                <tbody>
                <tr v-for="Ingredient_meal in Ingredients_meal" v-bind:key="Ingredient_meal" >
                    <td>{{Ingredient_meal.name_ingredients}}</td>
                    <td><input type="text" class="input" placeholder="Вес" id="weight_ingr" v-model="Ingredient_meal.weight_ingredients" @change="SetWeightIngredientMeal(Ingredient_meal.id_ingredients,
                    Ingredient_meal.weight_ingredients)"></td>
                    <td><button class="close_btn" style="width: 40px;  margin-right: 13%" v-bind:id="Ingredient_meal.id_ingredients" @click="DeleteIngredientMeal(Ingredient_meal.id_ingredients)">-</button></td>
                </tr>
                </tbody>
            </table>
            <div  >
                <table class="table_add">
                    <thead>
                    <tr>
                        <th> Название</th>
                        <th> + </th>


                    </tr>
                    </thead>
                    <tbody>
                    <tr v-for="Ingredient in Ingredients" v-bind:key="Ingredient" v-cloak>
                        <td>{{Ingredient.name_ingredients}}</td>
                        <td><button class="close_btn" style="width: 40px;  margin-right: 35%" @click="AddIngredientMeal(Ingredient.id_ingredients)">+</button></td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </div>




        </div>
    <!--    Модальное окно-->


</template>

<script>
    import {HostPatch} from "@/main";
    export default {
        name: "CardsEditor",
        data(){
            return{
                Ingredients: null,
                Cards: null,
                Meals: null,
                Groups:null,
                GroupMeal:null,
                HostPatch: HostPatch,
                Loading: false,
                ShowModal: false,
                Meal_item:null,
                Id_meal:null,
                Name_meal: null,
                Weight_meal: null,
                Price_meal: null,
                Instructions_meal: null,
                Img_meal:null,
                Ingredients_meal: null,
                Card_meal: [],
                file: null,

            }
        },
        methods:{
          async  SaveCardMeal(Id_meal, Name_meal, GroupMeal, Weight_meal, Price_meal, Instructions_meal,  Ingredients_meal){
                    const formData = new FormData();
                    formData.append('SaveCardMeal', 'SaveCardMeal');
                    formData.append('Id_meal', Id_meal);
                    formData.append('Name_meal', Name_meal);
                    formData.append('GroupMeal', GroupMeal);
                    formData.append('Weight_meal', Weight_meal);
                    formData.append('Price_meal', Price_meal);
                    formData.append('Instructions_meal', Instructions_meal);
                    if (this.file!=null){
                        console.log(this.file);
                        formData.append('Image', this.file);}




                    formData.append('Ingredients', JSON.stringify(Ingredients_meal));


                    const requestOptions = {
                        method: "POST",
                        body: formData
                    };
                    await fetch(HostPatch+`/EditCards.php`, requestOptions);

                    await this.Get();
            },

            saveImageToLocalStorage(data) {
                if (localStorage.getItem('userImage')!=null){
                    localStorage.removeItem('userImage');
                }

                try {

                    localStorage.setItem('userImage', data);
                    console.log('Изображение успешно сохранено в localStorage.');
                } catch (error) {
                    console.error('Произошла ошибка при сохранении изображения:', error);
                }
            },

            uploadImage(event) {

                this.file = event.target.files[0];
                if (this.file) {
                    const reader = new FileReader();
                    reader.readAsDataURL(this.file);
                    reader.onload = (e) => {
                        const imageData = e.target.result;
                        this.saveImageToLocalStorage(imageData);
                        let savedImageData = localStorage.getItem('userImage');
                        document.getElementById("card-product").src = savedImageData;
                    };

                }


            },

            SetWeightIngredientMeal(id_ingredients, weight_ingredients){
                for (let i=0; i<this.Ingredients_meal.length; i++){
                    if(this.Ingredients_meal[i].id_ingredients == id_ingredients){
                        this.Ingredients_meal[i].weight_ingredients = weight_ingredients;
                    }
                }
            },
            AddIngredientMeal(id_ingredients){
                for (let i=0; i<this.Ingredients_meal.length; i++){
                    if(this.Ingredients_meal[i].id_ingredients == id_ingredients){
                        return;
                    }
                }

               for (let i=0; i<this.Ingredients.length; i++){
                   if (this.Ingredients[i].id_ingredients == id_ingredients){
                       this.Ingredients_meal.push(this.Ingredients[i]);
                   }
               }
                this.Ingredients_meal.push()
            },

            DeleteIngredientMeal(id_ingredients){
                for(let i=0; i<this.Ingredients_meal.length; i++){
                    if (this.Ingredients_meal[i].id_ingredients == id_ingredients){
                        this.Ingredients_meal.splice(i, i+1);
                    }
                }
            },

            GetItem(id_item){
                for (let i = 0; i<this.Meals.length; i++){
                    this.Meal_item = this.Meals.slice(i, i+1);

                    if (this.Meal_item[0].id_meal == id_item){
                        this.Id_meal = this.Meal_item[0].id_meal;
                        this.Name_meal = this.Meal_item[0].name_meal;
                        this.Weight_meal = this.Meal_item[0].weight_meal;
                        this.Price_meal = this.Meal_item[0].price_meal;
                        this.Instructions_meal = this.Meal_item[0].instructions_meal;
                        this.Img_meal = this.Meal_item[0].pic_meal;
                        this.GroupMeal = this.Meal_item[0].id_group;
                        this.file = null;
                    }
                }
                    this.Card_meal.length = 0;
                    this.Ingredients_meal = [];
                    for (let i = 0; i<this.Cards.length; i++){
                        let Card_meal_temp = this.Cards.slice(i, i+1);
                        if (Card_meal_temp[0].id_meal == id_item){
                            for (let j=0; j<this.Ingredients.length; j++){
                                let Ingredient = this.Ingredients.slice(j, j+1);
                                let IngredientWithWeight ;
                                if (Ingredient[0].id_ingredients == Card_meal_temp[0].id_ingredients){
                                    IngredientWithWeight = Ingredient;
                                    IngredientWithWeight[0].weight_ingredients = (Card_meal_temp[0].weight_ingredients);
                                    this.Ingredients_meal.push(IngredientWithWeight[0]);
                                }
                            }
                        }
                        }
            },


            async Get(){
                this.Loading = true;
                this.Ingredients=null;
                let res =  await fetch(HostPatch+`/EditCards.php?Ingredients`);
                this.Ingredients =  await res.json();
                res =  await fetch(HostPatch+`/EditCards.php?Meals`);
                this.Meals =  await res.json();
                res =  await fetch(HostPatch+`/EditCards.php?Cards`);
                this.Cards =  await res.json();
                res =  await fetch(HostPatch+`/EditCards.php?Groups`);
                this.Groups =  await res.json();
                this.Loading = false;

            },

        },
        mounted() {
             this.Get('');
        }
    }
</script>

<style scoped>

</style>