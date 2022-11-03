import { getExpenseableTags, getIncomeableTags, getTransferableTags, getEnableTags } from '@/config/api.js';

export default {
	
	state: () => {
		return {
			expenseableTags: undefined,
			incomeableTags: undefined,
			transferableTags: undefined,
			enableTags: undefined,
		}
	},
	
	mutations: {
		setExpenseableTags(state, data) {
			state.expenseableTags = data;
		},
		setIncomeableTags(state, data) {
			state.incomeableTags = data;
		},
		setTransferableTags(state, data) {
			state.transferableTags = data;
		},
		setEnableTags(state, data) {
			state.enableTags = data;
		},
	},
	
	actions: {
		async getExpenseableTags({commit}) {
			commit('setExpenseableTags', await getExpenseableTags());
		},
		async getIncomeableTags({commit}) {
			commit('setIncomeableTags', await getIncomeableTags());
		},
		async getTransferableTags({commit}) {
			commit('setTransferableTags', await getTransferableTags());
		},
		async getEnableTags({commit}) {
			commit('setEnableTags', await getEnableTags());
		}
	},
	
	getters: {
		expenseableTags (state) {
			return state.expenseableTags;
		},
		incomeableTags (state) {
			return state.incomeableTags;
		},
		transferableTags (state) {
			return state.transferableTags;
		},
		enableTags (state) {
			return state.enableTags;
		}
	},
}