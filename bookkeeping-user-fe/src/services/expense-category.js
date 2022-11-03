import request from "@/utils/request";

const prefix = 'expense-categories';

// 给分类管理的table用
export async function query(params) {
  return request(prefix, {
    method: 'GET',
    params: params,
  });
}

// 给类别下拉选择框使用
export async function querySimple(params) {
  return request(prefix + '/enable', {
    method: 'GET',
    params: params,
  });
}

export async function create(json) {
  return request(prefix, {
    method: 'POST',
    data: json,
  });
}

export async function update(id, json) {
  return request(prefix + '/' + id, {
    method: 'PUT',
    data: json,
  });
}
