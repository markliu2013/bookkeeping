import { extend } from "umi-request";
import { message } from 'antd';
import { getUserToken } from '@/utils/util'

const request = extend({
  prefix: "/api/v1/",
  // prefix: "http://jz.jiukuaitech.com/api/v1/",
  timeout: 60000,
  headers: {
    "Content-Type": "application/json",
  },
  errorHandler: function(error) {
    // error.response.status
    if (error.data && error.data.errorMsg) {
      message.error(error.data.errorMsg);
    } else {
      console.log(error);
      message.error("系统异常，请稍后重试。");
    }
  }
});

// 自动跳转到登陆页
request.interceptors.response.use(async (response, options) => {
  const data = await response.clone().json();
  if (data.errorCode === 8 || data.errorCode === 10) {
    window.location.href = '/signin';
  }
  return response;
});

// 全局处理异常
request.interceptors.response.use(async (response, options) => {
  if (response.status === 200) {
    const data = await response.clone().json();
    if (!data.success) {
      message.error(data.errorMsg);
    }
  }
  return response;
});


// 添加token https://www.cnblogs.com/qkstart/p/11856168.html

request.interceptors.request.use(async (url, options) => {
  if (
    options.method === 'post' ||
    options.method === 'put' ||
    options.method === 'delete' ||
    options.method === 'get'
  ) {
    const headers = {
      'User-Token': getUserToken()
    };
    return {
      url,
      options: { ...options, headers },
    };
  }
});

export default request;
