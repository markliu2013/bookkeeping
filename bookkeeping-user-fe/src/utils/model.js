export const model = {
  reducers: {
    updateState(state, { payload }) {
      return { ...state, ...payload }
    },
  },
}
