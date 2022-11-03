import { useEffect, useState } from 'react';
import { useSelector } from 'umi';
import { Form, Space, Input } from 'antd';
import FormModal from "@/components/FormModal";
import FormItemDescription from '@/components/FormItemDescription';
import FormItemCreateTime from '@/components/FormItemCreateTime';
import moment from 'moment';
import {balanceRequiredRules, notesRules} from '@/utils/rules';
import { adjustBalance } from '@/services/account';
import {formProp} from "@/utils/var";
import {getNull, refreshFlow} from "@/utils/util";
import t from "@/utils/translate";
import styles from "./index.less";

export default () => {

  const [form] = Form.useForm();
  const { visible, currentItem } = useSelector(state => state.modal);

  const [initialValues, setInitialValues] = useState({});
  useEffect(() => {
    if (visible) {
      setInitialValues({
        ...getNull(form.getFieldsValue()), //统一将简单属性置空
        'createTime': moment(),
      });
    }
  }, [visible]);

  function successHandler(response) {
    refreshFlow(response.data);
  }

  return (
    <FormModal
      title={t('adjust.balance') + ' - ' + currentItem.name}
      form={form}
      initialValues={initialValues}
      update={adjustBalance}
      onSuccess={(response) => successHandler(response)}
    >
      <Form {...formProp} form={form} className={styles['form']}>
        <FormItemDescription />
        <Form.Item label={t('account.balance')}>
          <Space>
            <Form.Item name="balance" rules={balanceRequiredRules()} noStyle><Input /></Form.Item>
            <div>{t('account.current.balance')}: <span style={{color:"#14ba89"}}>{currentItem.balance}</span></div>
          </Space>
        </Form.Item>
        <FormItemCreateTime />
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
