import Vue from 'vue'
import uView from '@/uni_modules/uview-ui'

import App from './App'
import store from './store'
Vue.prototype.$store = store

var EventBus = new Vue()
Vue.prototype.$eventBus = EventBus

Vue.config.productionTip = false
App.mpType = 'app'

Vue.use(uView)
//uni.$u.config.unit = 'rpx'

const app = new Vue({
    ...App,
	store
})

require('@/config/request.js')(app)

app.$mount()