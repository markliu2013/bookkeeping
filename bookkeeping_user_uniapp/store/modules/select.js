export default {
	
	state: () => {
		return {
			selectList: undefined,
		}
	},
	
	mutations: {
		setSelectList(state, list) {
			state.selectList = list;
		}
	},
	
	actions: {
		
	},
	
	getters: {
		selectList (state) {
			return state.selectList;
		}
	},
	
}