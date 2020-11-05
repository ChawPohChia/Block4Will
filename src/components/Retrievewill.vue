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
  export default {
  name: 'Retrievewill', 
   data() {
    return {
      url: null,
      willHash: "QmQA6uANxuCAAjQ1wKzB5WAcXqozpYnPPD7XSTTANUyPW8",
      executorImageHash:"QmQA6uANxuCAAjQ1wKzB5WAcXqozpYnPPD7XSTTANUyPW8",
      totalWillsCount:null,
      form: {
        personaldetails: {
          details: null
        },       
        assetallocations: {
          allocations: null
        },
        retrieveWillHash:null,
      }
    }
   },
   
   methods: {
     //sample will hash: "efa3d898d0c97c329393fbddf8f46aeca721039d90cae19f370d40a37aebc552"
     
     
    RetrieveWill() {
      console.log("Retrieving will hash:" +this.form.retrieveWillHash);
      console.log("Retrieving executor image... ");
      let ipfsAPI= require('ipfs-http-client');
      let ipfs = ipfsAPI('localhost','5001',{protocol: 'http'}); 
      ipfs.cat(this.executorImageHash, (err, data) =>{
          if (err) console.log(err);       
          document.getElementById("executorPhoto").src = data.toString();
      });      
        
      const contractAddress = "0x473a514f40FD105D980Cbca33A7Ca3fb28992F75";
      const contractABI = [
        {
		"constant": true,
		"inputs": [],
		"name": "getWillsCount",
		"outputs": [
			{
				"name": "length",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "willHash",
				"type": "string"
			},
			{
				"name": "personalDetail",
				"type": "string"
			},
			{
				"name": "assetAllocation",
				"type": "string"
			},
			{
				"name": "executorImageIpfsHash",
				"type": "string"
			}
		],
		"name": "upload",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "willHash",
				"type": "string"
			}
		],
		"name": "getWill",
		"outputs": [
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "string"
			},
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	}       
      ];
      
      const Web3 = require("web3");
      const web3 = new Web3(window.ethereum);
      window.ethereum.enable();     
      const contract = new web3.eth.Contract(contractABI, contractAddress);

      contract.methods.getWill(this.form.retrieveWillHash).call({
            from: window.web3.eth.defaultAccount,
          }).then(async (res) => {
          
               console.log("Retriving Will with ID "+this.willHash+" :"+res[0]+res[1]+res[2]+res[3]);
               this.form.personaldetails.details=res[0];  
               this.form.assetallocations.allocations=res[1]; 
        });
      }
   }
  }
</script>