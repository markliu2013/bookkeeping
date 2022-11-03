import modelExtend from 'dva-model-extend';
import { model } from '@/utils/model';
import { query } from '@/services/expense';

export default modelExtend(model, {
  namespace: 'expenses',
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
        if (pathname === '/expenses') {
          dispatch({ type: 'query', payload: query });
        }
      });
    }
  }
})
