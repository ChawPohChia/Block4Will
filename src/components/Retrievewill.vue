// Retrievewill.vue

<template>
  <div>
  <h1>Will Retrieval Page</h1>  
  <img id="executorPhoto"/>    
  <form v-on:submit.prevent="RetrieveWill()">  
          <button type="submit" class="btn btn-primary">Submit Your Will</button>
  </form>
</div>
</template>

<script>
  export default {
  name: 'Retrievewill', 
   data() {
    return {
      url: null,
      executorImageHash:"QmQA6uANxuCAAjQ1wKzB5WAcXqozpYnPPD7XSTTANUyPW8"
    }
   },
   methods: {
    RetrieveWill() {
      console.log("Retrieving executor image... ");
      let ipfsAPI= require('ipfs-http-client');
      let ipfs = ipfsAPI('localhost','5001',{protocol: 'http'}); 
      ipfs.cat(this.executorImageHash, (err, data) =>{
          if (err) console.log(err);       
          document.getElementById("executorPhoto").src = data.toString();
      });      
      }
   }
  }
</script>