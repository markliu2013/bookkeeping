import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { querySimple } from '@/services/expense-category';

export default modelExtend(model, {
  namespace: 'expenseCategory',
  state: {
    querySimpleResponse: undefined,
  },
  effects: {
    *fetchSimple({ payload }, { call, put }) {
      const response = yield call(querySimple, payload);
      yield put({
        type: 'updateState',
        payload: { querySimpleResponse: response },
      });
    },
    *refresh(_, { __, put }) {
      yield put({ type: 'fetchSimple' });
    }
  },
})
