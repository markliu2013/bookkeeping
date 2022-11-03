import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { getAssetDebtTrend } from "@/services/report";

export default modelExtend(model, {
  namespace: 'assetDebtTrendReports',
  state: {
    queryResponse: undefined,
  },
  effects: {
    *query({ payload }, { call, put }) {
      const response = yield call(getAssetDebtTrend, payload);
      yield put({
        type: 'updateState',
        payload: { queryResponse: response },
      });
    },
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/reports/asset-debt-trend') {
          dispatch({ type: 'query', payload: query });
        }
      });
    }
  }
})
