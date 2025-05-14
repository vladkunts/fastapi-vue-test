import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue';
import Dashboard from '@/views/Dashboard.vue';


const routes = [
  {
    path: '/',
    name: "Home",
    component: Home,
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard,
    meta: { requiresAuth: true },
  },
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

// Redirect to dashboard if the user is already logged in
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')

  if (to.path === '/' && token) {
    return next('/dashboard')
  }

  next()
})

export default router