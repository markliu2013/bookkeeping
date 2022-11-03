import { getExpenseCategories } from '@/config/api.js';

export default {
	
	state: () => {
		return {
			expenseCategories: undefined,
		}
	},
	
	mutations: {
		setExpenseCategories(state, data) {
			state.expenseCategories = data;
		}
	},
	
	actions: {
		async getExpenseCategories({commit}) {
			commit('setExpenseCategories', await getExpenseCategories());
		}
	},
	
	getters: {
		expenseCategories (state) {
			return state.expenseCategories;
		}
	},
}