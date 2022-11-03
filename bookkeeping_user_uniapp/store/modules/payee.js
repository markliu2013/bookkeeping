import { getExpenseablePayees, getIncomeablePayees, getEnablePayees } from '@/config/api.js';

export default {
	
	state: () => {
		return {
			expenseablePayees: undefined,
			incomeablePayees: undefined,
			enablePayees: undefined,
		}
	},
	
	mutations: {
		setExpenseablePayees(state, data) {
			state.expenseablePayees = data;
		},
		setIncomeablePayees(state, data) {
			state.incomeablePayees = data;
		},
		setEnablePayees(state, data) {
			state.enablePayees = data;
		}
	},
	
	actions: {
		async getExpenseablePayees({commit}) {
			commit('setExpenseablePayees', await getExpenseablePayees());
		},
		async getIncomeablePayees({commit}) {
			commit('setIncomeablePayees', await getIncomeablePayees());
		},
		async getEnablePayees({commit}) {
			commit('setEnablePayees', await getEnablePayees());
		}
	},
	
	getters: {
		expenseablePayees (state) {
			return state.expenseablePayees;
		},
		incomeablePayees (state) {
			return state.incomeablePayees;
		},
		enablePayees (state) {
			return state.enablePayees;
		}
	},
}