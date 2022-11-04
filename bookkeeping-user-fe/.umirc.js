// ref: https://umijs.org/config/
import { defineConfig } from 'umi';

export default defineConfig({
  proxy: {
    '/api/v1': {
      'target': 'http://127.0.0.1:9092/',
      // 'target': 'http://testjz.jiukuaitech.com/',
      'changeOrigin': true,
    },
  },
  publicPath: process.env.NODE_ENV === 'production' ? 'http://static.jiukuaitech.com/' : '/',
  hash: true,
  antd: {
    compact: true
  },
  dva: {
    hmr: true,
  },
  locale: {
    default: 'zh-CN',
  },
  // dynamicImport: {
  //
  // },
  title: '九快记账',
})


