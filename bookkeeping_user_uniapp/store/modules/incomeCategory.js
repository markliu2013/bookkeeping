import { getIncomeCategories } from '@/config/api.js';

export default {
	
	state: () => {
		return {
			incomeCategories: undefined,
		}
	},
	
	mutations: {
		setIncomeCategories(state, data) {
			state.incomeCategories = data;
		}
	},
	
	actions: {
		async getIncomeCategories({commit}) {
			commit('setIncomeCategories', await getIncomeCategories());
		}
	},
	
	getters: {
		incomeCategories (state) {
			return state.incomeCategories;
		}
	},
}