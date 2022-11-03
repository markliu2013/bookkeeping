import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Input, message, Switch} from 'antd';
import { create, update } from '@/services/payee';
import FormModal from "@/components/FormModal";
import {nameRules, notesRules} from "@/utils/rules";
import {getNull, tableChangeQueryFormat, validateForm} from "@/utils/util";
import t from "@/utils/translate";
import styles from './index.less';

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const { visible, type, currentItem } = useSelector(state => state.modal);
  const { payeePagination : pagination, payeeSorter : sorter } = useSelector(state => state.categories);

  const [initialValues, setInitialValues] = useState({})
  useEffect(() => {
    if (visible) {
      if (type === 1) {
        setInitialValues({
          ...getNull(form.getFieldsValue()),
          expenseable: true,
          incomeable: false,
        });
      } else {
        setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
      }
    }
  }, [visible]);

  function successHandler(response) {
    dispatch({ type: 'categories/queryPayee', payload: tableChangeQueryFormat(pagination, sorter) });
    dispatch({ type: 'payee/refresh', payload: { ...response.data } });
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + t('payee')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={(response) => successHandler(response)}
    >
      <Form form={form} className={styles['form3']}>
        <Form.Item label={t('name')} name="name" rules={nameRules()}>
          <Input />
        </Form.Item>
        <Form.Item label={t('expenseable')} valuePropName="checked" name="expenseable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('incomeable')} valuePropName="checked" name="incomeable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
