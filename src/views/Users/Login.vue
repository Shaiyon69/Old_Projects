<template>
  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <form @submit.prevent="handleLogin">
          <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input type="email" class="form-control" id="email" v-model="email" placeholder="Enter email" required>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" v-model="password" placeholder="Password" required>
          </div>
          <button type="submit" class="btn btn-success w-100">Login</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  name: 'LoginView',
  data() {
    return {
      email: '',
      password: '',
      loading: false,
      error: null,
    };
  },
  methods: {
    async handleLogin() {
      this.loading = true;
      this.error = null;
      try {
        const response = await axios.post('http://10.109.4.244:8000/api/login',
          {
            email: this.email,
            password: this.password
          },
          {
            headers: {
              'Content-Type': 'application/json'
            }
          }
        );
        if (response.status === 200) {
          this.$router.push('/cars'); 
        }
      } catch (error) {
        this.error = error.response?.data?.message || 'Login failed';
        console.error("Error during login:", error);
      }
    },
  },
}
</script>


