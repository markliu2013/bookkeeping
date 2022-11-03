import modelExtend from 'dva-model-extend';
import {model} from '@/utils/model';
import {getUploadToken} from '@/services/flow-image';
import {getImages} from '@/services/flow';

export default modelExtend(model, {
  namespace: 'flow',
  state: {
    uploadToken: undefined,
    images: undefined,
  },
  effects: {
    *fetchUploadToken(_, { call, put }) {
      const response = yield call(getUploadToken);
      if (response && response.success && response.data) {
        yield put({
          type: 'updateState',
          payload: {
            uploadToken: response.data,
          },
        });
      }
    },
    *fetchImages({ payload }, { call, put }) {
      const response = yield call(getImages, payload.id);
      if (response && response.success && response.data) {
        yield put({
          type: 'updateState',
          payload: {
            images: response.data,
          },
        });
      }
    },
  }
})
