import request from "@/utils/request";

export async function register(params) {
  return request('register', {
    method: 'POST',
    data: params,
  });
}

export async function signin(params) {
  return request('signin', {
    method: 'POST',
    data: params,
  });
}

export async function updatePassword(params) {
  return request('updatePassword', {
    method: 'PUT',
    data: params,
  });
}

export async function getSessionUser() {
  return request('session', {
    method: 'GET',
  });
}

export async function setDefaultBook(id) {
  return request('setDefaultBook/' + id, {
    method: 'PUT',
  });
}

export async function setDefaultGroup(id) {
  return request('setDefaultGroup/' + id, {
    method: 'PUT',
  });
}
