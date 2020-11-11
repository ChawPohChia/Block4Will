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
      <button type="submit" class="btn btn-primary">Submit Your Will</button><br><br>
      <label id="message">After submit, please wait until your will hash appear...</label>
    </form>
  </section>
</template>

<script>
import { sha256 } from 'js-sha256';
import contract from '@/contract';

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
      form: {
        personaldetails: {
          details: null
        },
        assetallocations: {
          allocations: null
        },
        executor: {
          executorIpfsImageHash: null
        },

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
        this.form.executor.executorIpfsImageHash = fileInfo[0].hash;
        console.log('Uploaded to IPFS successfully! Hash: '+ this.form.executor.executorIpfsImageHash);
      });
    },

    SubmitWill() {     
      console.log("submiting will ...");
      console.log("Personal Details: " + this.form.personaldetails.details);
      console.log("Asset Allocations: " + this.form.assetallocations.allocations);
      console.log("Executor Hash: " + this.form.executor.executorIpfsImageHash);
        
      const willHash = sha256(JSON.stringify(this.form));
      console.log("WillHash:"+willHash)

      contract.methods
          .upload(
            willHash,            
            this.form.personaldetails.details,
            this.form.assetallocations.allocations,
            this.form.executor.executorIpfsImageHash
          )
          .send({
            from: window.web3.eth.defaultAccount,
          })
          .on('confirmation', (confirmNumber) => {
            // Wait for 2 ticks so that the results gets reflected in the blockchain first.
            if (confirmNumber === 2) {
              console.log("Congratulation, your will has been persisted to Block! Your will hash is "+willHash);
              document.getElementById("message").innerHTML  = "Congratulation! Your will has been persisted to blockchain! To retrieve your will, using this hash: "+willHash;
            }
          })
          .on('error', (err) => {
            console.log("Error happens during upload of will. Err: "+err);
            document.getElementById("message").innerHTML  = "Error happens during upload of will. Err: "+err;
          });
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