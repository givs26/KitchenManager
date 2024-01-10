<template>
    <div class="header">
       <img src="../assets/pictures/logo.png" class="image-header">
        <div class="header-title">КУХНЯ</div>
    </div>
</template>

<script>
    export default {
        name: "HeaderApp"
    }
</script>

<style scoped>
.header{
    margin-right: auto;
    margin-left: auto;
    border-radius: 26px;
    background: #D9D9D9;
    height: 196px;
    width: 90%;


}
.header-title{
    color: #8E5508;
    position: absolute;
    left: 45%;
    right: auto;
    top: 50px;
    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    font-family: Kaisei HarunoUmi;
    font-size: 87px;
    font-style: normal;
    font-weight: 400;
    line-height: normal;
}
    .image-header{

        margin-left: 20px;
        margin-top: 20px;
        width: 250px;
        height: 150px;

        border-radius: 26px;

        box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
    }
</style>