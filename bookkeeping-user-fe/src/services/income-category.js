import request from "@/utils/request";

const prefix = 'income-categories';

export async function query(params) {
  return request(prefix, {
    method: 'GET',
    params: params,
  });
}

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
