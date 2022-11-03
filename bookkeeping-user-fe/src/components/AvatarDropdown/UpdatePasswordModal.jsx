import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Input, Select, Switch} from 'antd';
import { updatePassword } from '@/services/user';
import {useResponseSelectData} from "@/utils/hooks";
import {requiredRules} from "@/utils/rules";
import FormModal from "@/components/FormModal";
import styles from './index.less';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible } = useSelector(state => state.modal);

  function successHandler() {
    localStorage.removeItem('userToken');
    window.location.href = "/signin";
  }

  return (
    <FormModal
      title={t('update.password')}
      form={form}
      create={updatePassword}
      onSuccess={successHandler}
    >
      <Form form={form} className={styles['form3']}>
        <Form.Item label={t('old.password')} name="oldPassword" rules={requiredRules()}>
          <Input type="password" />
        </Form.Item>
        <Form.Item label={t('new.password')} name="newPassword" rules={requiredRules()}>
          <Input type="password" />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
