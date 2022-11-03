import modelExtend from 'dva-model-extend';
import { model } from '@/utils/model';
import { audit } from '@/services/flow';

export default modelExtend(model, {
  namespace: 'audit',
  state: {
    queryResponse: undefined,
  },
  effects: {
    *query({ payload }, { call, put }) {
      const response = yield call(audit, payload);
      yield put({
        type: 'updateState',
        payload: { queryResponse: response },
      });
    },
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/audit') {
          dispatch({ type: 'query', payload: query });
        }
      });
    }
  }
})
