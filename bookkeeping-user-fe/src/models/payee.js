import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getEnable, getExpenseable, getIncomeable } from '@/services/payee';

export default modelExtend(model, {
  namespace: 'payee',
  state: {
    getEnableResponse: undefined,
    getExpenseableResponse: undefined,
    getIncomeableResponse: undefined,
  },
  effects: {
    *fetchEnable(_, { call, put }) {
      const response = yield call(getEnable);
      yield put({
        type: 'updateState',
        payload: { getEnableResponse: response },
      });
    },
    *fetchExpenseable(_, { call, put }) {
      const response = yield call(getExpenseable);
      yield put({
        type: 'updateState',
        payload: { getExpenseableResponse: response },
      });
    },
    *fetchIncomeable(_, { call, put }) {
      const response = yield call(getIncomeable);
      yield put({
        type: 'updateState',
        payload: { getIncomeableResponse: response },
      });
    },
    *refresh({ payload }, { _, put }) {
      yield put({ type: 'fetchEnable' });
      //if (payload.expenseable) {
        yield put({ type: 'fetchExpenseable' });
      //}
      //if (payload.incomeable) {
        yield put({ type: 'fetchIncomeable' });
      //}
    }
  },
})
