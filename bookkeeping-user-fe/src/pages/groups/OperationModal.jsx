import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Modal, Form, Input, message, Select} from 'antd';
import { create, update } from '@/services/group';
import {getNull, validateForm} from "@/utils/util";
import t from "@/utils/translate";
import FormModal from "@/components/FormModal";
import {nameRules, notesRules, requiredRules} from "@/utils/rules";
import styles from './index.less';
import {useCurrencyResponseSelectData} from "@/utils/hooks";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const [initialValues, setInitialValues] = useState(currentItem)
  useEffect(() => {
    if (!visible) return;
    if (type === 1) {
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        ...{
          defaultCurrencyCode: 'CNY'
        }
      });
    } else {
      setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
    }
  }, [visible]);

  useEffect(() => {
    if (!currencyResponse) dispatch({ type: 'currency/fetchAll' });
  }, []);
  const { getAllResponse : currencyResponse } = useSelector(state => state.currency);
  const [currencyList] = useCurrencyResponseSelectData(currencyResponse);

  function successHandler() {
    dispatch({ type: 'groups/query' });
    dispatch({ type: 'session/fetchSession' })
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + t('group')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={successHandler}
    >
      <Form form={form} className={styles['form2']}>
        <Form.Item label={t('group.name')} name="name" rules={nameRules()}>
          <Input />
        </Form.Item>
        <Form.Item label={t('default.currency')} name="defaultCurrencyCode" rules={requiredRules()} labelCol={{ style: { width: 68 } }}>
          <Select options={currencyList} showArrow showSearch filterOption optionFilterProp={"label"} disabled={type === 2} />
        </Form.Item>
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
