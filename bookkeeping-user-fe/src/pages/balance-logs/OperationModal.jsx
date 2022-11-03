import { useEffect, useState } from 'react';
import {history, useDispatch, useSelector} from 'umi';
import {DatePicker, Form, Input} from 'antd';
import moment from "moment";
import { create } from '@/services/log';
import {getNull} from "@/utils/util";
import {balanceRequiredRules, timeRequiredRules} from "@/utils/rules";
import FormModal from "@/components/FormModal";
import styles from './index.less';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible } = useSelector(state => state.modal);

  const [initialValues, setInitialValues] = useState({});
  useEffect(() => {
    if (!visible) return;
    setInitialValues({
      ...getNull(form.getFieldsValue()),
      'createTime': moment(),
    });
  }, [visible]);

  function successHandler() {
    dispatch({ type: 'logs/query', payload: history.location.query });
  }

  return (
    <FormModal
      title={t('new') + t('balance.log')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={create}
      onSuccess={successHandler}
    >
      <Form form={form} className={styles['form3']}>
        <Form.Item label={t('flow.createTime')} name="createTime" rules={timeRequiredRules()}>
          <DatePicker showTime={false} format='YYYY-MM-DD' />
        </Form.Item>
        <Form.Item label={t('asset.balance')} name="asset" rules={balanceRequiredRules()}>
          <Input />
        </Form.Item>
        <Form.Item label={t('debt.balance')} name="debt" rules={balanceRequiredRules()}>
          <Input />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
