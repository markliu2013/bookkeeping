import request from "@/utils/request";

const prefix = 'reports';

export async function getExpenseCategory(params) {
  return request(prefix + '/expense-category', {
    method: 'GET',
    params: params,
  });
}

export async function getExpenseTag(params) {
  return request(prefix + '/expense-tag', {
    method: 'GET',
    params: params,
  });
}

export async function getIncomeCategory(params) {
  return request(prefix + '/income-category', {
    method: 'GET',
    params: params,
  });
}

export async function getIncomeTag(params) {
  return request(prefix + '/income-tag', {
    method: 'GET',
    params: params,
  });
}

export async function getExpenseIncomeTrend(params) {
  return request(prefix + '/expense-income-trend', {
    method: 'GET',
    params: params,
  });
}

export async function getAssetDebtTrend(params) {
  return request(prefix + '/asset-debt-trend', {
    method: 'GET',
    params: params,
  });
}

export async function getAsset() {
  return request(prefix + '/asset', {
    method: 'GET',
  });
}

export async function getDebt() {
  return request(prefix + '/debt', {
    method: 'GET',
  });
}
