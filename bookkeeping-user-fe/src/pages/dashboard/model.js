import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getAssetOverview, getExpenseIncomeTable, getExpenseTrend, getIncomeTrend, getExpenseCategory, getIncomeCategory } from '@/services/dashboard';

export default modelExtend(model, {
  namespace: 'dashboard',
  state: {
    getAssetOverviewResponse: undefined,
    getExpenseIncomeTableResponse: undefined,
    getExpenseTrendResponse: undefined,
    getIncomeTrendResponse: undefined,
    getExpenseCategoryResponse: undefined,
    getIncomeCategoryResponse: undefined,
  },
  effects: {
    *fetchAssetOverview(_, { call, put }) {
      const response = yield call(getAssetOverview);
      yield put({
        type: 'updateState',
        payload: { getAssetOverviewResponse: response },
      });
    },
    *fetchExpenseIncomeTable(_, { call, put }) {
      const response = yield call(getExpenseIncomeTable);
      yield put({
        type: 'updateState',
        payload: { getExpenseIncomeTableResponse: response },
      });
    },
    *fetchExpenseTrend(_, { call, put }) {
      const response = yield call(getExpenseTrend);
      yield put({
        type: 'updateState',
        payload: { getExpenseTrendResponse: response },
      });
    },
    *fetchIncomeTrend(_, { call, put }) {
      const response = yield call(getIncomeTrend);
      yield put({
        type: 'updateState',
        payload: { getIncomeTrendResponse: response },
      });
    },
    *fetchExpenseCategory({ payload }, { call, put }) {
      const response = yield call(getExpenseCategory, payload);
      yield put({
        type: 'updateState',
        payload: { getExpenseCategoryResponse: response },
      });
    },
    *fetchIncomeCategory({ payload }, { call, put }) {
      const response = yield call(getIncomeCategory, payload);
      yield put({
        type: 'updateState',
        payload: { getIncomeCategoryResponse: response },
      });
    },
  },
})
