import request from "@/utils/request";

const prefix = 'items';

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
  return request(prefix + '/' + id, {
    method: 'PUT',
    data: json,
  });
}

export async function run(id, json) {
  return request(prefix + '/' + id + '/run', {
    method: 'PUT',
    data: json,
  });
}

export async function recall(id, json) {
  return request(prefix + '/' + id + '/recall', {
    method: 'PUT',
    data: json,
  });
}

export async function remove(id) {
  return request(prefix + '/' + id, {
    method: 'DELETE',
  });
}
