// Retrievewill.vue
<template>
  <section>
    <div class="row align-items-center jumbotron jumbotron-fluid page-header home full">
      <div class="col-md-12">
        <div class="container">
          <h1 class="display-4">Will Retrieval</h1>
          <p class="lead">Retrieve your will here</p>
        </div>
      </div>
    </div>

    <form v-on:submit.prevent="RetrieveWill()">
      <div class="form-group">
        <label for="retrieveWillHash">Please enter will hash here</label>
        <textarea
          class="form-control"
          rows="5"
          id="personaldetails"
          v-model="form.retrieveWillHash"
        ></textarea>
      </div>      
      <button type="submit" class="btn btn-primary">Retrieve Your Will</button><br>
      
      <div class="form-group">
        <label for="personaldetails">Will owner details:</label>
        <textarea
          class="form-control"
          rows="5"
          id="personaldetails"
          v-model="form.personaldetails.details"
        ></textarea>
      </div>

      <div class="form-group">
        <label for="assetallocations">Will owner asset allocations:</label>
        <textarea
          class="form-control"
          rows="5"
          id="assetallocations"
          v-model="form.assetallocations.allocations"
        ></textarea>
      </div>

      <div class="form-group">
        <label>Will executor image:</label>
        <div id="preview">
          <img id="executorPhoto" /><br>
        </div>
      </div>    
    </form>
  </section>
</template>

<script>
 import contract from '@/contract';

  export default {
  name: 'Retrievewill', 
   data() {
    return {
      url: null,
      totalWillsCount:null,
      form: {
        personaldetails: {
          details: null
        },       
        assetallocations: {
          allocations: null
        },
        retrieveWillHash:null,
        executorImageHash:null,
      }
    }
   },
   
   methods: {
     RetrieveExecutorImage(ipfsImageHash){
       console.log("Retrieving executor image... ");
       let ipfsAPI= require('ipfs-http-client');
       let ipfs = ipfsAPI('localhost','5001',{protocol: 'http'}); 
       ipfs.cat(ipfsImageHash, (err, data) =>{
          if (err) console.log(err);       
          document.getElementById("executorPhoto").src = data.toString();
      });   

     },
     
    RetrieveWill() {
      console.log("Retrieving will hash:" +this.form.retrieveWillHash);  
      contract.methods.getWill(this.form.retrieveWillHash).call({
            from: window.web3.eth.defaultAccount,
          }).then(async (res) => {
               //Return formar: Wills[i].personalDetail, Wills[i].assetAllocation, Wills[i].executorImageIpfsHash, Wills[i].dateAddedIntoSmartContrac
               console.log("Retriving Will with ID "+this.willHash+" :"+res[0]+res[1]+res[2]+res[3]);
               this.form.personaldetails.details=res[0];  
               this.form.assetallocations.allocations=res[1]; 
               this.form.executorImageHash=res[2];
               this.RetrieveExecutorImage(this.form.executorImageHash);
        });
      }
   }
  }
</script>