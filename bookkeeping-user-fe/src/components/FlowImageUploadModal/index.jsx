import {useEffect, useState} from "react";
import {useDispatch, useSelector} from "umi";
import {message, Modal, Upload} from "antd";
import {updateImages} from '@/services/flow';
import t from "@/utils/translate";
import {PlusOutlined} from "@ant-design/icons";

export default (props) => {

  const dispatch = useDispatch();

  const { user } = useSelector(state => state.session);
  const { visible, currentItem } = useSelector(state => state.modal);
  const { images, uploadToken } = useSelector(state => state.flow);

  useEffect(() => {
    if (currentItem && currentItem.id) {
      dispatch({ type: 'flow/fetchImages', payload: {id: currentItem.id} });
    }
  }, [currentItem]);

  useEffect(() => {
    if (visible) {
      dispatch({ type: 'flow/fetchUploadToken' })
    }
  }, [visible]);

  function cancelHandler() {
    dispatch({ type: 'modal/hide' });
  }

  useEffect(() => {
    if (images) {
      setFileList(
        images.map(image => {
          return {
            uid: image.id,
            id: image.id,
            status: 'done',
            url: image.url,
          }
        })
      );
    }
  }, [images]);

  const [fileList, setFileList] = useState([]);
  const [uploadError, setUploadError] = useState(false);
  useEffect(() => {
    if (uploadError) {
      let newFileList = [...fileList];
      setFileList(newFileList.filter(file => {
        if (!file.status) return false; //beforeUpload没通过
        if (file.status === 'error') return false; //七牛报错
        if (file.status === 'done' && (file.response && !file.response.success)) return false; //文件已存在，回调报错
        return true;
      }));
      setUploadError(false);
    }
  }, [uploadError]);

  const messageFileSize = t('upload.size.error');
  const uploadProps = {
    accept: 'image/jpeg, image/png, application/pdf',
    multiple: true,
    maxCount: 3,
    fileList: fileList,
    listType: 'picture-card',
    action: 'http://upload-z2.qiniup.com',
    data: {
      'token': uploadToken,
      'x:userId': user && user.id
    },
    onChange(info) {
      let newFileList = [...info.fileList];
      newFileList = newFileList.map(file => {
        if (file.status === 'done' && file.response && file.response.success) {
          file.url = file.response.data.url;
          file.id = file.response.data.id;
        }
        return file;
      });
      setFileList(newFileList);
      if (info.file.status === 'error') {
        message.error(info.file.response.error);
        setUploadError(true);
      }
      if (info.file.status === 'done') {
        if (!info.file.response.success) {
          message.error(info.file.response.errorMsg);
          setUploadError(true);
        }
      }
    },
    beforeUpload(file) {
      let isOk = true;
      if (file.size > 1.5*1024*1024) {
        message.error(messageFileSize);
        isOk = false;
      }
      if (isOk) dispatch({ type: 'flow/fetchUploadToken' });
      if (!isOk) setUploadError(true);
      return isOk;
    }
  }

  const messageOperationSuccess = t('operation.success');
  const [confirmLoading, setConfirmLoading] = useState(false);
  async function okHandler() {
    setConfirmLoading(true);
    const response = await updateImages(currentItem.id, fileList.map(i=>i.id));
    if (response && response.success) {
      cancelHandler();
      message.success(messageOperationSuccess);
    }
    setConfirmLoading(false);
  }

  return (
    <Modal
      forceRender={true}
      maskClosable={false}
      title={t('flow.image')}
      visible={visible}
      onOk={okHandler}
      onCancel={cancelHandler}
      confirmLoading={confirmLoading}
    >
      <Upload {...uploadProps}>
        {
          fileList.length >= 3 ?
            null :
            <div>
              <PlusOutlined />
              <div style={{ marginTop: 8 }}>Upload</div>
            </div>
        }
      </Upload>

    </Modal>
  )

}
