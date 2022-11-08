import { getSession } from '@/config/api.js';

export default {
	
	state: () => {
		return {
			userToken: undefined,
			user: undefined,
			defaultBook: undefined,
			defaultGroup: undefined,
			apiUrl: undefined,
		}
	},
	
	getters: {
		userToken(state) {
			if (state.userToken) {
				return state.userToken;
			} else {
				const userToken = uni.getStorageSync('userToken');
				state.userToken = userToken;
				return userToken;
			}
		},
		user(state) {
			return state.user;
		},
		defaultBook(state) {
			return state.defaultBook;
		},
		defaultGroup(state) {
			return state.defaultGroup;
		},
		defaultCurrencyCode(state) {
			return state.defaultGroup.defaultCurrencyCode
		},
		apiUrl(state) {
			if (state.apiUrl) {
				return state.apiUrl;
			} else {
				const apiUrl = uni.getStorageSync('apiUrl');
				state.apiUrl = apiUrl;
				return apiUrl;
			}
		},
	},
	
	actions: {
		async getSession({ commit }) {
			const data = await getSession();
			commit('setUser', data.userSessionVO);
			commit('setDefaultBook', data.defaultBook);
			commit('setDefaultGroup', data.defaultGroup);
		}
	},
	
	mutations: {
		updateToken: (state, userToken) => {
			state.userToken = userToken;
			uni.setStorageSync('userToken', userToken);
		},
		setUser: (state, user) => {
			state.user = user;
		},
		setDefaultBook: (state, book) => {
			state.defaultBook = book;
		},
		setDefaultGroup: (state, group) => {
			state.defaultGroup = group;
		},
		updateApiUrl: (state, apiUrl) => {
			state.apiUrl = apiUrl;
			uni.setStorageSync('apiUrl', apiUrl);
		},
	}
	
}