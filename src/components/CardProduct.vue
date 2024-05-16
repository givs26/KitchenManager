<template>
    <div class="card-product" id="{{ProductID}}">

            <div class="card-product-title">{{ProductName}}</div>

        <div class="div-img">
        <img class="card-product-img" v-bind:src="ProductImage">
        </div>
        <div class="card-product-descr">
            <div class="card-product-descr-title"><div class="weight">Вес: {{ProductWeight}}</div></div>
            <div class="card-product-descr-title"><div class="price">Цена: {{ProductPrice}}</div></div>
    </div>
        <div class="input-buttons">
            <input class="input_qty" type="text" name="ProductQty" v-model="ProductQty">
            <button class="add_button"  style="width: 100px" @click="this.$emit('add-meal-to-order', ProductID, ProductQty,  ProductName, ProductPrice), ProductQty=null">Добавить</button>
        </div>
    </div>
</template>

<script>
    export default {

        name: "CardProduct",
        data(){
            return{
                ProductQty: null
            }
        },
        props: {
            ProductID: null,
            ProductName: null,
            ProductWeight: null,
            ProductPrice:null,
            ProductImage: null,

        },
        methods:{

        },

    }
</script>

<style scoped>

</style>