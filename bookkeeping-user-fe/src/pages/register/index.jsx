import { useEffect } from 'react';
import { Form, Input, Button, message } from 'antd';
import { Link, useDispatch, useSelector } from 'umi';
import { UserOutlined, LockOutlined, VerifiedOutlined, MailOutlined } from '@ant-design/icons';
import { userNameRules, passwordRules, emailRules, requiredRules }  from '@/utils/rules';
import t from '@/utils/translate';

import styles from './index.less';

export default () => {

  const dispatch = useDispatch();
  const { registerResponse } = useSelector(state => state.userRegister);
  const submitting = useSelector(state => state.loading.effects['userRegister/submit']);

  const messageRegisterSuccess = t('register.success');
  useEffect(() => {
    if (registerResponse && registerResponse.success) {
      message.success(messageRegisterSuccess);
    }
    return () => {
      dispatch({ type: 'userRegister/clearRegisterResponse' });
    }
  }, [registerResponse]);

  const handleSubmit = (values) => {
    dispatch({ type: 'userRegister/submit', payload: { ...values }, });
  };

  return (
    <div className={styles.main}>
      <Form size="large" onFinish={ handleSubmit }>
        <Form.Item name="userName" rules={ userNameRules() }>
          <Input autoFocus prefix={<UserOutlined className="site-form-item-icon" />} placeholder={t('placeholder.userName')} />
        </Form.Item>
        <Form.Item name="password" rules={ passwordRules() }>
          <Input prefix={<LockOutlined className="site-form-item-icon" />} type="password" placeholder={t('placeholder.password')} />
        </Form.Item>
        <Form.Item name="inviteCode" rules={ requiredRules() }>
          <Input prefix={<VerifiedOutlined className="site-form-item-icon" />} placeholder={t('placeholder.invite.code')} />
        </Form.Item>
        <Form.Item name="email" rules={ emailRules() }>
          <Input prefix={<MailOutlined className="site-form-item-icon" />} type="eamil" placeholder={t('placeholder.email')} />
        </Form.Item>
        <div className={styles.form_row}>
          <Button size="large" type="primary" htmlType="submit" block loading={ submitting }>{t('register')}</Button>
        </div>
        <div className={styles.form_row} style={{textAlign: "center"}}>
          <Link to="/signin">{t('register.signin')}</Link>
        </div>
      </Form>
    </div>
  );
};
