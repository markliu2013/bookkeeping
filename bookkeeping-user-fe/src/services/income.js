import request from "@/utils/request";

const prefix = 'incomes';

export async function query(params) {
  return request(prefix, {
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
  return request(prefix+'/'+id, {
    method: 'PUT',
    data: json,
  });
}

export async function refund(id, json) {
  return request(prefix + '/' + id + '/refund', {
    method: 'POST',
    data: json,
  });
}
