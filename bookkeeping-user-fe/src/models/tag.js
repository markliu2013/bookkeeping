import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getEnable, getExpenseable, getIncomeable, getTransferable } from '@/services/tag';

export default modelExtend(model, {
  namespace: 'tag',
  state: {
    getEnableResponse: undefined,
    getExpenseableResponse: undefined,
    getIncomeableResponse: undefined,
    getTransferableResponse: undefined,
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
    *fetchTransferable(_, { call, put }) {
      const response = yield call(getTransferable);
      yield put({
        type: 'updateState',
        payload: { getTransferableResponse: response },
      });
    },
    *refresh({ payload }, { _, put }) {
      yield put({ type: 'fetchEnable' });
      //if (payload.expenseable) {
        yield put({ type: 'fetchExpenseable' });
     // }
      //if (payload.incomeable) {
        yield put({ type: 'fetchIncomeable' });
      //}
      //if (payload.transferable) {
        yield put({ type: 'fetchTransferable' });
      //}
    }
  },
})
