import {useEffect, useState} from 'react';
import {useDispatch, useSelector} from "umi";
import {Modal, Button, message} from "antd";
import {validateForm} from "@/utils/util";
import t from '@/utils/translate';

export default (props) => {

  const dispatch = useDispatch();

  const {
    title,
    form,
    initialValues,
    create,
    update,
    refund,
    onSuccess,
    onParseValues
  } = props;

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const messageOperationSuccess = t('operation.success');
  const [confirmLoading, setConfirmLoading] = useState(false);
  async function okHandler() {
    setConfirmLoading(true);
    const values = await validateForm(form);
    if (values) {
      if (values.createTime) values.createTime = values.createTime.valueOf();
      if (onParseValues) onParseValues(values);
      // if (type === 2) {
      //   if (values.accountId) {
      //     if (currentItem.account.id === values.accountId) delete values.accountId;
      //   }
      //   if (values.categories) {
      //     if (JSON.stringify(currentItem.categories) === JSON.stringify(values.categories)) delete values.categories;
      //   }
      //   if (values.tags) {
      //     if (JSON.stringify(currentItem.tags.map(i => i.tagId)) === JSON.stringify(values.tags)) delete values.tags;
      //   }
      //   if (values.fromId) if (currentItem.fromId == values.fromId) delete values.fromId;
      //   if (values.toId) if (currentItem.toId == values.toId) delete values.toId;
      // }
      const response = type === 2 ? await update(currentItem.id, values) : type === 4 ? await refund(currentItem.id, values) : await create(values);
      if (response && response.success) {
        cancelHandler();
        message.success(messageOperationSuccess);
        onSuccess(response);
      }
    }
    setConfirmLoading(false);
  }

  function resetHandler() {
    form.setFieldsValue({...initialValues});
  }

  useEffect(() => {
    if (initialValues && Object.keys(initialValues).length > 0) {
      form.setFieldsValue({...initialValues});
    }
  }, [initialValues]);

  function cancelHandler() {
    dispatch({ type: 'modal/hide' });
  }

  return (
    <Modal
      width={600}
      forceRender={true}
      maskClosable={false}
      title={title}
      visible={visible}
      onOk={okHandler}
      onCancel={cancelHandler}
      footer={[
        <Button key="back" onClick={cancelHandler}>{t('form.cancel')}</Button>,
        <Button key="reset" onClick={resetHandler}>{t('form.reset')}</Button>,
        <Button key="submit" type="primary" loading={confirmLoading} onClick={okHandler}>{t('form.submit')}</Button>,
      ]}
    >
      {props.children}
    </Modal>
  );

};
