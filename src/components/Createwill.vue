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
          <img v-if="url" :src="url" />
        </div>
        <input type="file" @change="onFileChange" />
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
    SubmitWill() {
      console.log("submiting press, image binary: " + this.executorImage);
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