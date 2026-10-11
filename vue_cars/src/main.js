import { createApp } from 'vue'
import App from './App.vue'
import router, { isLoggedIn } from './router'
import 'bootstrap/dist/css/bootstrap.min.css'

// Check for stored auth token on app load
const token = localStorage.getItem('authToken');
if (token) {
  isLoggedIn.value = true;
}

createApp(App).use(router).mount('#app')
