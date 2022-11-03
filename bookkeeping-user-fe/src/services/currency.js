import request from '@/utils/request';

const prefix = 'currency';

export async function getAll() {
  return request(prefix + '/all', {
    method: 'GET'
  });
}
