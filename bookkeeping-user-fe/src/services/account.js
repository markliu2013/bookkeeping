import request from "@/utils/request";

const prefix = 'accounts';

// 搜索流水，按账户查找的下拉框
export async function getEnable() {
  return request(prefix + '/enable', {
    method: 'GET',
  });
}

export async function getExpenseable() {
  return request(prefix + '/expenseable', {
    method: 'GET',
  });
}

export async function getIncomeable() {
  return request(prefix + '/incomeable', {
    method: 'GET',
  });
}

export async function getTransferFromAble() {
  return request(prefix + '/transfer-from-able', {
    method: 'GET',
  });
}

export async function getTransferToAble() {
  return request(prefix + '/transfer-to-able', {
    method: 'GET',
  });
}

export async function adjustBalance(id, json) {
  return request(prefix + '/' + id + '/adjust-balance', {
    method: 'POST',
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

export async function toggleInclude(id) {
  return request(prefix + '/' + id + '/toggleInclude', {
    method: 'PUT',
  });
}

export async function toggleExpenseable(id) {
  return request(prefix + '/' + id + '/toggleExpenseable', {
    method: 'PUT',
  });
}

export async function toggleIncomeable(id) {
  return request(prefix + '/' + id + '/toggleIncomeable', {
    method: 'PUT',
  });
}

export async function toggleTransferFromAble(id) {
  return request(prefix + '/' + id + '/toggleTransferFromAble', {
    method: 'PUT',
  });
}

export async function toggleTransferToAble(id) {
  return request(prefix + '/' + id + '/toggleTransferToAble', {
    method: 'PUT',
  });
}

export async function update(id, json) {
  return request(prefix+'/'+id, {
    method: 'PUT',
    data: json,
  });
}
