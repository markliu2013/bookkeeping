import { useEffect } from 'react';
import { Form, Input, Checkbox, Button, message } from 'antd';
import { Link, history, useDispatch, useSelector } from 'umi';
import { UserOutlined, LockOutlined } from '@ant-design/icons';
import { userNameRules, passwordRules }  from '@/utils/rules';
import t from '@/utils/translate';

import styles from './index.less';

export default () => {

  const dispatch = useDispatch();
  const { signInResponse } = useSelector(state => state.userSignIn);
  const submitting = useSelector(state => state.loading.effects['userSignIn/submit']);

  const messageLoginSuccess = t('signin.success');
  useEffect(() => {
    if (signInResponse && signInResponse.success) {
      message.success(messageLoginSuccess);
      history.push({ pathname: '/dashboard' });
    }
    return () => {
      dispatch({ type: 'userSignIn/clearSignInResponse' });
    }
  }, [signInResponse]);

  const handleSubmit = (values) => {
    dispatch({ type: "userSignIn/submit", payload: { ...values } });
  };

  return (
    <div className={styles.main}>
      <Form size="large" onFinish={ handleSubmit }>
        <Form.Item name="userName" rules={ userNameRules() }>
          <Input prefix={<UserOutlined className="site-form-item-icon" />} placeholder={t('placeholder.userName')} />
        </Form.Item>
        <Form.Item name="password" rules={ passwordRules() }>
          <Input prefix={<LockOutlined className="site-form-item-icon" />} type="password" placeholder={t('placeholder.password')} />
        </Form.Item>
        <div className={styles.form_row}>
          <Form.Item name="remember" valuePropName="checked" noStyle>
            <Checkbox>{t('signin.keep')}</Checkbox>
          </Form.Item>
          {/*<Link to="/register" style={{float: 'right'}}>{t('signin.forget')}</Link>*/}
        </div>
        <div className={styles.form_row}>
          <Button size="large" type="primary" htmlType="submit" block loading={ submitting }>{t('signin')}</Button>
        </div>
        <div className={styles.form_row} style={{textAlign: "center"}}>
          <Link to="/register">{t('register')}</Link>
        </div>
      </Form>
    </div>
  );
}
