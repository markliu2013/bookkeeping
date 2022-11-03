import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { query } from '@/services/transfer';

export default modelExtend(model, {
  namespace: 'transfers',
  state: {
    queryResponse: undefined,
  },
  effects: {
    *query({ payload }, { call, put }) {
      const response = yield call(query, payload);
      yield put({
        type: 'updateState',
        payload: { queryResponse: response },
      });
    },
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/transfers') {
          dispatch({ type: 'query', payload: query });
        }
      });
    }
  }
})
