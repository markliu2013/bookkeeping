import { register } from '@/services/user';

export default {
  namespace: 'userRegister',
  state: {
    registerResponse: undefined,
  },
  effects: {
    *submit({ payload }, { call, put }) {
      const response = yield call(register, payload);
      yield put({
        type: 'registerHandler',
        payload: response,
      });
    }
  },
  reducers: {
    registerHandler(state, { payload }) {
      return { ...state, registerResponse: payload };
    },
    clearRegisterResponse(state) {
      return { ...state, registerResponse: undefined };
    }
  }
}
