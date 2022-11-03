import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import { query as queryCheckingAccount } from '@/services/checking-account';
import { query as queryCreditAccount } from '@/services/credit-account';
import { query as queryDebtAccount } from '@/services/debt-account';
import { query as queryAssetAccount } from '@/services/asset-account';
import {tableChangeQueryFormat} from '@/utils/util';

export default modelExtend(model, {
  namespace: 'accounts',
  state: {
    currentAccountType: 1,

    checkingAccountPagination: { },
    checkingAccountSorter: { },
    queryCheckingAccountResponse: undefined,

    creditAccountPagination: { },
    creditAccountSorter: { },
    queryCreditAccountResponse: undefined,

    debtAccountPagination: { },
    debtAccountSorter: { },
    queryDebtAccountResponse: undefined,

    assetAccountPagination: { },
    assetAccountSorter: { },
    queryAssetAccountResponse: undefined,

  },
  effects: {
    *queryCheckingAccount({ payload }, { call, put }) {
      const response = yield call(queryCheckingAccount, payload);
      yield put({
        type: 'updateState',
        payload: { queryCheckingAccountResponse: response },
      });
    },
    *queryCreditAccount({ payload }, { call, put }) {
      const response = yield call(queryCreditAccount, payload);
      yield put({
        type: 'updateState',
        payload: { queryCreditAccountResponse: response },
      });
    },
    *queryDebtAccount({ payload }, { call, put }) {
      const response = yield call(queryDebtAccount, payload);
      yield put({
        type: 'updateState',
        payload: { queryDebtAccountResponse: response },
      });
    },
    *queryAssetAccount({ payload }, { call, put }) {
      const response = yield call(queryAssetAccount, payload);
      yield put({
        type: 'updateState',
        payload: { queryAssetAccountResponse: response },
      });
    },
    *refresh(_, { __, put, select }) {
      const {
        currentAccountType,
        checkingAccountPagination,
        checkingAccountSorter,
        creditAccountPagination,
        creditAccountSorter,
        debtAccountPagination,
        debtAccountSorter,
        assetAccountPagination,
        assetAccountSorter
      } = yield select(state => state.accounts);
      switch (currentAccountType) {
        case 1:
          yield put({ type: 'queryCheckingAccount', payload: tableChangeQueryFormat(checkingAccountPagination, checkingAccountSorter) });
          break;
        case 2:
          yield put({ type: 'queryCreditAccount', payload: tableChangeQueryFormat(creditAccountPagination, creditAccountSorter) });
          break;
        case 3:
          yield put({ type: 'queryDebtAccount', payload: tableChangeQueryFormat(debtAccountPagination, debtAccountSorter) });
          break;
        case 4:
          yield put({ type: 'queryAssetAccount', payload: tableChangeQueryFormat(assetAccountPagination, assetAccountSorter) });
          break;
      }
    }
  },
})
