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
      errorMessage: null,
      successMessage: null,
      loading: false,
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
      this.loading = true;
      this.errorMessage = null;
      this.successMessage = null;
      console.log(
        "submiting press " +
          this.form.assetallocations.allocations +
          " " +
          this.form.personaldetails.details
      );
    }
    
	
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss"></style>