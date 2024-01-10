<template>
 <HeaderApp/>
 <OrdersMain/>

</template>

<script>

import HeaderApp from "@/components/HeaderApp";
import OrdersMain from "@/components/OrdersMain";


export default {
  name: 'App',
  components: {
   OrdersMain,
    HeaderApp,



  }
}
</script>

<style>
#app {

}
</style>
