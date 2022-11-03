import request from "@/utils/request";

const prefix = 'flow-images';

export async function getUploadToken() {
  return request(prefix + '/upload-token', {
    method: 'GET',
  });
}

