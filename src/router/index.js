import { createRouter, createWebHistory } from 'vue-router'
import { ref } from 'vue'
import HomeView from '../views/HomeView.vue'

const isLoggedIn = ref(false)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  {
    path: '/cars',
    name: 'cars',
    component: () => import(/* webpackChunkName: "cars" */ '../views/CarsView.vue')
  },
  {
    path: '/users/login',
    name: 'login',
    component: () => import(/* webpackChunkName: "login" */ '../views/Users/Login.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

router.beforeEach((to, from, next) => {
  if ((to.path === '/users/login' || to.path === '/login') && isLoggedIn.value) {
    next('/cars')
  }
  else if ((to.path === '/cars') && !isLoggedIn.value) {
    next('/users/login')
  } else {
    next()
  }

})

export default router
