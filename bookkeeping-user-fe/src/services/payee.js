import request from '@/utils/request';

const prefix = 'payees';

export async function query(params) {
  return request(prefix, {
    method: 'GET',
    params: params,
  });
}

export async function getEnable() {
  return request(prefix + '/enable', {
    method: 'GET'
  });
}

export async function getExpenseable() {
  return request(prefix + '/expenseable', {
    method: 'GET'
  });
}

export async function getIncomeable() {
  return request(prefix + '/incomeable', {
    method: 'GET'
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

export async function remove(id) {
  return request(prefix + '/' + id, {
    method: 'DELETE',
  });
}

export async function toggle(id) {
  return request(prefix + '/' + id + '/toggle', {
    method: 'PUT',
  });
}
