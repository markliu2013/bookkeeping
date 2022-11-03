import request from '@/utils/request';

const prefix = 'adjust-balances';

export async function query(params) {
  return request(prefix, {
    method: 'GET',
    params: params,
  });
}

export async function remove(id) {
  return request(prefix + '/'+id, {
    method: 'DELETE',
  });
}
