import request from '@/utils/request';

const prefix = 'debt-accounts';

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

export async function sum() {
  return request(prefix+'/sum', {
    method: 'GET',
  });
}
