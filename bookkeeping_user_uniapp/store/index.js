import Vue from 'vue'
import Vuex from 'vuex'

import session from './modules/session'
import account from './modules/account'
import payee from './modules/payee'
import tag from './modules/tag'
import select from './modules/select'
import expenseCategory from './modules/expenseCategory'
import incomeCategory from './modules/incomeCategory'
import modelForm from './modules/modelForm'

Vue.use(Vuex) // vue的插件机制

export default new Vuex.Store({
	modules: {
		session, account, select, expenseCategory, incomeCategory, payee, tag, modelForm
	}
})