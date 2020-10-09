import { createRouter, createWebHistory } from 'vue-router'
import Mainpage from '@/components/Mainpage.vue';


const routes = [
  {
    path: '/',
    name: 'Mainpage',
    component: Mainpage
  },
  {
    path: '/Createwill',
    name: 'Createwill',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "Createwill" */ '../components/Createwill.vue')
  },
  {
    path: '/Retrievewill',
    name: 'Retrievewill',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "Retrievewill" */ '../components/Retrievewill.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
