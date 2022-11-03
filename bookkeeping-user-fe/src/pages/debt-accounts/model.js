import {history} from "umi";
import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import {query, sum} from "@/services/debt-account";

export default modelExtend(model, {
  namespace: 'debtAccounts',
  state: {
    queryResponse: undefined,
    sumResponse: undefined,
    currentTime: Date.now()
  },
  effects: {
    *sum(_, { call, put }) {
      const response = yield call(sum);
      yield put({
        type: 'updateState',
        payload: { sumResponse: response },
      });
    },
    *query({ payload }, { call, put }) {
      const response = yield call(query, { ...payload, ...{ enable: true } });
      yield put({
        type: 'updateState',
        payload: { queryResponse: response },
      });
    },
    *refresh(_, { call, put, select }) {
      yield put({ type: 'query', payload: history.location.query });
      yield put({ type: 'sum' });
      // 更新账户的流水记录
      yield put({ type: 'updateState', payload: {currentTime: new Date()} });
    }
  },
  subscriptions: {
    setup({ dispatch, history }) {
      return history.listen(({ pathname, query }) => {
        if (pathname === '/debt-accounts') {
          dispatch({ type: 'query', payload: query });
        }
      });
    }
  }
})
