import { getExpenseableAccounts, getIncomeableAccounts, getTransferFromAbleAccounts, getTransferToAbleAccounts, getEnableAccounts } from '@/config/api.js';

export default {
	
	state: () => {
		return {
			expenseableAccounts: undefined,
			incomeableAccounts: undefined,
			transferFromAbleAccounts: undefined,
			transferToAbleAccounts: undefined,
			enableAccounts: undefined,
		}
	},
	
	mutations: {
		setExpenseableAccounts(state, data) {
			state.expenseableAccounts = data;
		},
		setIncomeableAccounts(state, data) {
			state.incomeableAccounts = data;
		},
		setTransferFromAbleAccounts(state, data) {
			state.transferFromAbleAccounts = data;
		},
		setTransferToAbleAccounts(state, data) {
			state.transferToAbleAccounts = data;
		},
		setEnableAccounts(state, data) {
			state.enableAccounts = data;
		}
	},
	
	actions: {
		async getExpenseableAccounts({commit}) {
			commit('setExpenseableAccounts', await getExpenseableAccounts());
		},
		async getIncomeableAccounts({commit}) {
			commit('setIncomeableAccounts', await getIncomeableAccounts());
		},
		async getTransferFromAbleAccounts({commit}) {
			commit('setTransferFromAbleAccounts', await getTransferFromAbleAccounts());
		},
		async getTransferToAbleAccounts({commit}) {
			commit('setTransferToAbleAccounts', await getTransferToAbleAccounts());
		},
		async getEnableAccounts({commit}) {
			commit('setEnableAccounts', await getEnableAccounts());
		}
	},
	
	getters: {
		expenseableAccounts (state) {
			return state.expenseableAccounts;
		},
		incomeableAccounts (state) {
			return state.incomeableAccounts;
		},
		transferFromAbleAccounts (state) {
			return state.transferFromAbleAccounts;
		},
		transferToAbleAccounts (state) {
			return state.transferToAbleAccounts;
		},
		enableAccounts (state) {
			return state.enableAccounts;
		}
	},
}