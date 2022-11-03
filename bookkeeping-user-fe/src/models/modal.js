export default {
  namespace: 'modal',
  state: {
    component: null,
    visible: false,
    currentItem: { },
    type: 1, // 1是新增，2是更新，3是复制, 4是退款
  },
  reducers: {
    show(state, { payload }) {
      return { ...state, ...payload, visible: true }
    },
    hide(state) {
      return { ...state, visible: false, currentItem: { } }
    },
  },
}
