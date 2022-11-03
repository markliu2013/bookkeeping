import request from "@/utils/request";

const prefix = 'categories';

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
