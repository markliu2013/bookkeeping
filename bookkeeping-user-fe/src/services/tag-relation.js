import request from "@/utils/request";

const prefix = 'tag-relations';

export async function update(id, json) {
  return request(prefix + '/' + id, {
    method: 'PUT',
    data: json,
  });
}
