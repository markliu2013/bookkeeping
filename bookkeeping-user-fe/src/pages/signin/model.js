import { signin } from '@/services/user';

export default {
  namespace: 'userSignIn',
  state: {
    signInResponse: undefined,
  },
  effects: {
    *submit({ payload }, { put, call }) {
      const response = yield call(signin, payload);
      yield put({
        type: 'signInHandler',
        payload: response,
      });
    }
  },
  reducers: {
    signInHandler(state, { payload }) {
      return { ...state, signInResponse: payload };
    },
    clearSignInResponse(state) {
      return { ...state, signInResponse: undefined };
    }
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/signin') {
          // token有可能失效，导致死循环跳转。
          // if (localStorage.getItem("userToken")) {
          //   history.push({ pathname: '/dashboard' });
          // }
        }
      });
    }
  }
}
