import request from "@/utils/request";

const prefix = 'dashboard';

export async function getAssetOverview() {
  return request(prefix + '/asset-overview', {
    method: 'GET',
  });
}

export async function getExpenseIncomeTable() {
  return request(prefix + '/expense-income-table', {
    method: 'GET',
  });
}

export async function getExpenseTrend() {
  return request(prefix + '/expense-trend', {
    method: 'GET',
  });
}

export async function getIncomeTrend() {
  return request(prefix + '/income-trend', {
    method: 'GET',
  });
}

export async function getExpenseCategory(params) {
  return request(prefix + '/expense-category', {
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




