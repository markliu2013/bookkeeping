import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getExpenseIncomeTrend } from "@/services/report";

export default modelExtend(model, {
  namespace: 'expenseIncomeTrendReports',
  state: {
    queryResponse: undefined,
  },
  effects: {
    *query({ payload }, { call, put }) {
      const response = yield call(getExpenseIncomeTrend, payload);
      yield put({
        type: 'updateState',
        payload: { queryResponse: response },
      });
    },
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/reports/expense-income-trend') {
          console.log(query);
          if (query && query.breakType) {
            dispatch({ type: 'query', payload: query });
          }
        }
      });
    }
  }
})
