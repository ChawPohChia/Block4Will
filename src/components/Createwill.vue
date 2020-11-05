// Createwill.vue

<template>
  <section>
    <div class="row align-items-center jumbotron jumbotron-fluid page-header home full">
      <div class="col-md-12">
        <div class="container">
          <h1 class="display-4">Will Creation</h1>
          <p class="lead">Draft your will here</p>
        </div>
      </div>
    </div>

    <form v-on:submit.prevent="SubmitWill()">
      <div class="form-group">
        <label for="personaldetails">Please enter your personal details</label>
        <textarea
          class="form-control"
          rows="5"
          id="personaldetails"
          v-model="form.personaldetails.details"
        ></textarea>
      </div>
      <div class="form-group">
        <label for="assetallocations">Please enter your asset allocation plans:</label>
        <textarea
          class="form-control"
          rows="5"
          id="assetallocations"
          v-model="form.assetallocations.allocations"
        ></textarea>
      </div>

      <div class="form-group">
        <label>Please upload an image of your executor:</label>
        <div id="preview">
          <img v-if="url" :src="url" /><br>
        </div>
        <input type="file" @change="onFileChange"/><br><br><br>
        <button type="button" @click="UploadToIPFS">Upload Executor Image to IPFS</button> <br>
       </div>

      <button type="submit" class="btn btn-primary">Submit Your Will</button>
    </form>
  </section>
</template>

<script>
export default {
  name: "Createwill",
  metaInfo() {
    return {
      title: `New Transaction | ${process.env.VUE_APP_TITLE}`
    };
  },

  data() {
    return {
      url: null,
      executorImage: null,
      executorImageIpfsHash: null,
      form: {
        personaldetails: {
          details: null
        },
        assetallocations: {
          allocations: null
        }
      }
    };
  },

  methods: {
    UploadToIPFS() {
      console.log("Uploading to IPFS...");
      //Persist to ipfs
      let ipfsAPI = require("ipfs-http-client");
      let ipfs = ipfsAPI("localhost", "5001", { protocol: "http" });
      ipfs.add(Buffer.from(this.executorImage), (err, fileInfo) => {
        if (err) console.log(err);
        this.executorImageIpfsHash = fileInfo[0].hash;
        console.log('Uploaded to IPFS successfully! Hash: ',this.executorImageIpfsHash);
      });
    },

    SubmitWill() {     
      console.log("submiting will ...");
      console.log("Personal Details: " + this.form.personaldetails.details);
      console.log(
        "Asset Allocations: " + this.form.assetallocations.allocations
      );
      console.log("Executor Hash: " + this.executorImageIpfsHash);
        
      const contractAddress = "0x473a514f40FD105D980Cbca33A7Ca3fb28992F75";
      const contractABI = [
        {
          constant: true,
          inputs: [],
          name: "getWillsCount",
          outputs: [
            {
              name: "length",
              type: "uint256"
            }
          ],
          payable: false,
          stateMutability: "view",
          type: "function"
        },
        {
          constant: false,
          inputs: [
            {
              name: "willHash",
              type: "string"
            },
            {
              name: "personalDetail",
              type: "string"
            },
            {
              name: "assetAllocation",
              type: "string"
            },
            {
              name: "executorImageIpfsHash",
              type: "string"
            }
          ],
          name: "upload",
          outputs: [
            {
              name: "",
              type: "string"
            }
          ],
          payable: false,
          stateMutability: "nonpayable",
          type: "function"
        },
        {
          constant: true,
          inputs: [
            {
              name: "willHash",
              type: "string"
            }
          ],
          name: "getWill",
          outputs: [
            {
              name: "",
              type: "string"
            },
            {
              name: "",
              type: "string"
            },
            {
              name: "",
              type: "string"
            },
            {
              name: "",
              type: "uint256"
            }
          ],
          payable: false,
          stateMutability: "view",
          type: "function"
        },
        {
          inputs: [],
          payable: false,
          stateMutability: "nonpayable",
          type: "constructor"
        }
      ];
      
      const Web3 = require("web3");
      const web3 = new Web3(window.ethereum);
      window.ethereum.enable();     
      const contract = new web3.eth.Contract(contractABI, contractAddress);

      contract.methods
          .upload(
            'testing123',            
            this.form.personaldetails.details,
            this.form.assetallocations.allocations,
            this.executorImageIpfsHash
          )
          .send({
            from: window.web3.eth.defaultAccount,
          })
    },

    readImage(imagefile) {
      var fr = new FileReader();
      fr.onload = e => (this.executorImage = e.target.result);
      fr.readAsDataURL(imagefile);
    },

    onFileChange(e) {
      const file = e.target.files[0];
      this.url = URL.createObjectURL(file);
      this.readImage(file);      
    }
  }
};
</script>
<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss"></style>