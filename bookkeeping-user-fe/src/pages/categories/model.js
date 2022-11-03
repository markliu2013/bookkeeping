import modelExtend from 'dva-model-extend';
import { model } from '@/utils/model';
import { query as queryExpenseCategory } from '@/services/expense-category';
import { query as queryIncomeCategory } from '@/services/income-category';
import { query as queryTag } from '@/services/tag';
import { query as queryPayee } from '@/services/payee';

export default modelExtend(model, {
  namespace: 'categories',
  state: {
    currentCategoryType: 1,

    queryExpenseCategoryResponse: undefined,
    queryIncomeCategoryResponse: undefined,
    queryTagResponse: undefined,
    queryPayeeResponse: undefined,

    payeePagination: { },
    payeeSorter: { },
    payeeQueryData: { },

    expenseCategoryQueryData: { },
    incomeCategoryQueryData: { },
    tagQueryData: { },

  },
  effects: {
    *queryExpenseCategory({ payload }, { call, put }) {
      const response = yield call(queryExpenseCategory, payload);
      yield put({
        type: 'updateState',
        payload: { queryExpenseCategoryResponse: response },
      });
    },
    *queryIncomeCategory({ payload }, { call, put }) {
      const response = yield call(queryIncomeCategory, payload);
      yield put({
        type: 'updateState',
        payload: { queryIncomeCategoryResponse: response },
      });
    },
    *queryTag({ payload }, { call, put }) {
      const response = yield call(queryTag, payload);
      yield put({
        type: 'updateState',
        payload: { queryTagResponse: response },
      });
    },
    *queryPayee({ payload }, { call, put }) {
      const response = yield call(queryPayee, payload);
      yield put({
        type: 'updateState',
        payload: { queryPayeeResponse: response },
      });
    },
  },
})
