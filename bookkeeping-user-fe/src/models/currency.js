import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getAll } from '@/services/currency';

export default modelExtend(model, {
  namespace: 'currency',
  state: {
    getAllResponse: undefined,
  },
  effects: {
    *fetchAll(_, { call, put }) {
      const response = yield call(getAll);
      yield put({
        type: 'updateState',
        payload: { getAllResponse: response },
      });
    }
  },
})
