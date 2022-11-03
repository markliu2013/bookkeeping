import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Input, message, Switch, TreeSelect} from 'antd';
import { create, update } from '@/services/tag';
import FormModal from "@/components/FormModal";
import {nameRules, notesRules} from "@/utils/rules";
import {getNull, tableChangeQueryFormat, validateForm} from "@/utils/util";
import {useCategoryTreeSelectData} from "@/utils/hooks";
import t from "@/utils/translate";
import styles from './index.less';

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { visible, type, currentItem } = useSelector(state => state.modal);

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
      if (type === 1) {
        setInitialValues({
          ...getNull(form.getFieldsValue()),
          ...{
            expenseable: currentItem && currentItem.expenseable ? currentItem.expenseable : true,
            incomeable: currentItem && currentItem.incomeable ? currentItem.incomeable : false,
            transferable: currentItem && currentItem.transferable ? currentItem.transferable :false,
            parentId: currentItem && currentItem.id ? currentItem.id : null,
          }
        });
      } else {
        setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
      }
    }
  }, [visible]);

  function successHandler(response) {
    dispatch({ type: 'categories/queryTag' });
    dispatch({ type: 'tag/refresh', payload: { ...response.data } });
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + t('tag')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={(response) => successHandler(response)}
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
    </FormModal>
  );
}
