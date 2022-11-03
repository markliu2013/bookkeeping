import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getIncomeTag as getTagReport } from '@/services/report';

export default modelExtend(model, {
  namespace: 'incomeTagReports',
  state: {
    queryResponse: undefined,
  },
  effects: {
    *query({ payload }, { call, put }) {
      const response = yield call(getTagReport, payload);
      yield put({
        type: 'updateState',
        payload: { queryResponse: response },
      });
    },
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/reports/income-tag') {
          dispatch({ type: 'query', payload: query });
        }
      });
    }
  }
})
