import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { query as queryCategory } from '@/services/expense-category';
import { getExpenseCategory as getCategoryReport } from '@/services/report';

export default modelExtend(model, {
  namespace: 'expenseCategoryReports',
  state: {
    getCategoryResponse: undefined,
    queryResponse: undefined,
  },
  effects: {
    *getCategory({ payload }, { call, put }) {
      const response = yield call(queryCategory, payload);
      yield put({
        type: 'updateState',
        payload: { getCategoryResponse: response },
      });
    },
    *query({ payload }, { call, put }) {
      const response = yield call(getCategoryReport, payload);
      yield put({
        type: 'updateState',
        payload: { queryResponse: response },
      });
    },
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/reports/expense-category') {
          dispatch({ type: 'query', payload: query });
        }
      });
    }
  }
})
