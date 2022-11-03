export default {
	namespaced: true,
	state: () => {
		return {
			type: 1, //1-新增，2-修改，3-复制，4-退款
			model: undefined,
		}
	},
	
	mutations: {
		setModel(state, model) {
			state.model = model;
		},
		setType(state, type) {
			state.type = type;
		}
	},
	
	getters: {
		model (state) {
			return state.model;
		},
		type (state) {
			return state.type
		}
	},
	
}