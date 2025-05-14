import './assets/main.css'
import axios from 'axios'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)

axios.defaults.withCredentials = true
axios.defaults.baseURL = import.meta.env.VITE_API_URL

axios.interceptors.response.use(
  response => response,
  error => {
    if (error.response && error.response.status === 401) {
      // token expired or invalid
      localStorage.removeItem('token')
      router.push('/')
    }
    return Promise.reject(error)
  }
)

app.use(router)
app.mount('#app')
