import request from "@/utils/request";

const prefix = 'deals';

export async function getRefunds(id) {
  return request(prefix + '/' + id + '/refunds', {
    method: 'GET',
  });
}
