import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import {getSessionUser} from '@/services/user';

export default modelExtend(model, {
  namespace: 'session',
  state: {
    user: undefined,
    defaultBook: undefined,
    defaultGroup: undefined,
  },
  effects: {
    *fetchSession(_, { call, put }) {
      const response = yield call(getSessionUser);
      if (response && response.success && response.data) {
        yield put({
          type: 'updateState',
          payload: {
            user: response.data.userSessionVO,
            defaultBook: response.data.defaultBook,
            defaultGroup: response.data.defaultGroup,
          },
        });
      }
    },
  }
})
