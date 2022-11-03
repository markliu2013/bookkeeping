import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getEnable, getExpenseable, getIncomeable, getTransferFromAble, getTransferToAble } from '@/services/account';

export default modelExtend(model, {
  namespace: 'account',
  state: {
    getEnableResponse: undefined,
    getExpenseableResponse: undefined,
    getIncomeableResponse: undefined,
    getTransferFromAbleResponse: undefined,
    getTransferToAbleResponse: undefined,
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
    *fetchTransferFromAble(_, { call, put }) {
      const response = yield call(getTransferFromAble);
      yield put({
        type: 'updateState',
        payload: { getTransferFromAbleResponse: response },
      });
    },
    *fetchTransferToAble(_, { call, put }) {
      const response = yield call(getTransferToAble);
      yield put({
        type: 'updateState',
        payload: { getTransferToAbleResponse: response },
      });
    },
    *refresh(_, { __, put }) {
      yield put({ type: 'fetchEnable' });
      //if (payload.expenseable) {
        yield put({ type: 'fetchExpenseable' });
      //}
      //if (payload.incomeable) {
        yield put({ type: 'fetchIncomeable' });
      //}
      //if (payload.transferFromAble) {
        yield put({ type: 'fetchTransferFromAble' });
      //}
      //if (payload.transferToAble) {
        yield put({ type: 'fetchTransferToAble' });
      //}
    },
  },
})
