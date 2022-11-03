import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Input, message, Modal, Switch, TreeSelect} from 'antd';
import { create } from '@/services/tag';
import {nameRules, notesRules} from "@/utils/rules";
import {getNull, validateForm} from "@/utils/util";
import {useCategoryTreeSelectData} from "@/utils/hooks";
import t from "@/utils/translate";
import styles from './index.less';

export default (props) => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { visible, onHide, type } = props;

  const { getEnableResponse : tagResponse } = useSelector(state => state.tag);
  const [treeData] = useCategoryTreeSelectData(tagResponse);
  useEffect(() => {
    if (visible) {
      if (!tagResponse) dispatch({ type: 'tag/fetchEnable' });
    }
  }, [visible]);

  const [initialValues, setInitialValues] = useState({})
  useEffect(() => {
    if (visible) {
      form.setFieldsValue({
        ...getNull(form.getFieldsValue()),
        ...{
          expenseable: type === 1 ? true : false,
          incomeable: type === 2 ? true : false,
          transferable: type === 3 ? true : false,
          parentId: null,
        }
      });
    }
  }, [visible]);

  const messageOperationSuccess = t('operation.success');
  const [confirmLoading, setConfirmLoading] = useState(false);
  async function okHandler() {
    setConfirmLoading(true);
    const values = await validateForm(form);
    if (values) {
      const response = await create(values);
      if (response && response.success) {
        onHide();
        message.success(messageOperationSuccess);
        dispatch({ type: 'tag/refresh', payload: { ...response.data } });
      }
    }
    setConfirmLoading(false);
  }

  function successHandler(response) {
    onHide();
  }

  return (
    <Modal
      forceRender={true}
      maskClosable={false}
      title={t('new') + t('tag')}
      visible={visible}
      onOk={okHandler}
      onCancel={onHide}
      confirmLoading={confirmLoading}
    >
      <Form form={form} className={styles['form']}>
        <Form.Item label={t('parent.category')} name="parentId">
          <TreeSelect
            allowClear={true}
            treeDataSimpleMode={true}
            treeData={treeData}
            showArrow={true}
            showSearch={true}
            treeNodeFilterProp="title"
            treeDefaultExpandAll={false} />
        </Form.Item>
        <Form.Item label={t('name')} name="name" rules={nameRules()}>
          <Input />
        </Form.Item>
        <Form.Item label={t('expenseable')} valuePropName="checked" name="expenseable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('incomeable')} valuePropName="checked" name="incomeable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('transferable')} valuePropName="checked" name="transferable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </Modal>
  );
}
