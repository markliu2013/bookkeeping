import { useEffect, useState } from 'react';
import {history, useDispatch, useSelector} from 'umi';
import {Form, Input, message} from 'antd';
import {getNull, validateForm, refreshFlow} from "@/utils/util";
import {amountRequiredRules} from "@/utils/rules";
import FormModal from "@/components/FormModal";
import {update} from '@/services/tag-relation';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, currentItem } = useSelector(state => state.modal);
  const { defaultBook } = useSelector(state => state.session);
  useEffect(() => {
    if (!defaultBook) dispatch({ type: 'session/fetchSession' });
  }, []);

  const [initialValues, setInitialValues] = useState({})
  useEffect(() => {
    if (visible) {
      currentItem.amount = currentItem.amount.toString();
      setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
    }
  }, [visible]);

  function successHandler() {
    refreshFlow();
  }

  return (
    <FormModal
      title={t('update.tag.amount')}
      form={form}
      initialValues={initialValues}
      update={update}
      onSuccess={successHandler}
    >
      <Form form={form}>
        <Form.Item label={t('tag.amount')} name="amount" rules={amountRequiredRules()}>
          <Input />
        </Form.Item>
        {
          defaultBook && defaultBook.defaultCurrencyCode !== currentItem.currencyCode ?
          <Form.Item label={t('convertCurrency')+defaultBook.defaultCurrencyCode} name="convertedAmount" rules={amountRequiredRules()}>
            <Input />
          </Form.Item> : null
        }
      </Form>
    </FormModal>
  );
}
