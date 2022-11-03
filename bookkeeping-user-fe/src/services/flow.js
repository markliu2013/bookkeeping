import request from "@/utils/request";

const prefix = 'flows';

export async function query(params) {
  return request(prefix, {
    method: 'GET',
    params: params,
  });
}

export async function remove(record) {
  return request(prefix + '/' + record.id, {
    method: 'DELETE',
  });
}

export async function confirm(record) {
  return request(prefix + '/' + record.id + '/confirm', {
    method: 'PUT',
  });
}

export async function audit(params) {
  return request(prefix + '/audit', {
    method: 'GET',
    params: params,
  });
}

export async function getImages(id) {
  return request(prefix + '/' + id + '/images', {
    method: 'GET',
  });
}

export async function updateImages(id, images) {
  return request(prefix + '/' + id + '/images', {
    method: 'POST',
    data: images,
  });
}

