<template>
    <div class="header">
<!--       <div><img src="../assets/pictures/logo.png" class="image-header"></div>-->
        <div class="header-title">{{HeaderTitle}}</div>
    </div>
</template>

<script>


    export default {
        name: "HeaderApp",
        data(){
            return{

            }
        },
        props: {
            HeaderTitle: null
        }
    }
</script>

<style scoped>
.header{
    display: inline-flex;
    margin-right: 5%;
    margin-left: 5%;
    border-radius: 26px;
    background: #D9D9D9;
    height: 50px;
    width: 90%;


}
.header-title{
    margin: auto;
    color: #8E5508;
    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    font-family: Kaisei HarunoUmi;
    font-size: 20px;
    font-style: normal;

}

</style>