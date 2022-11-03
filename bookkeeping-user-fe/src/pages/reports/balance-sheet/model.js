import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getAsset, getDebt } from '@/services/report'
import {query as queryCategory} from "@/services/expense-category";

export default modelExtend(model, {
  namespace: 'balanceSheetReports',
  state: {
    getAssetResponse: undefined,
    getDebtResponse: undefined,
  },
  effects: {
    *getAsset(_, { call, put }) {
      const response = yield call(getAsset);
      yield put({
        type: 'updateState',
        payload: { getAssetResponse: response },
      });
    },
    *getDebt(_, { call, put }) {
      const response = yield call(getDebt);
      yield put({
        type: 'updateState',
        payload: { getDebtResponse: response },
      });
    },
  },
})
