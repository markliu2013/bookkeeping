import {useEffect} from "react";
import {history, connect, useSelector, useDispatch} from 'umi';
import { Avatar, Menu, Spin } from 'antd';
import moment from "moment";
import { LogoutOutlined, LockOutlined, UserOutlined } from '@ant-design/icons';
import HeaderDropdown from '@/components/HeaderDropdown';
import UpdatePasswordModal from './UpdatePasswordModal';
import t from '@/utils/translate';
import styles from './index.less';

export default (props) => {

  const dispatch = useDispatch();
  const { user } = useSelector(state => state.session);
  useEffect(() => {
    if (!user) dispatch({ type: 'session/fetchSession' });
  }, []);

  const onMenuClick = (event) => {
    const { key } = event;
    if (key === 'logout') {
      localStorage.removeItem('userToken');
      window.location.href = "/signin";
    }
    if (key === 'updatePassword') {
      dispatch({ type: 'modal/show', payload: {component: UpdatePasswordModal }});
    }
  };

  const {
    currentUser = {
      avatar: 'https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png',
      name: user && user.userName ? user.userName : t('signin'),
      vipTime:  user && user.vipTime ? user.vipTime : 0
    },
    menu,
  } = props;

  const menuHeaderDropdown = (
    <Menu className={styles.menu} selectedKeys={[]} onClick={onMenuClick}>
      {menu && (<Menu.Item key="center"><UserOutlined />{t('profile')}</Menu.Item>)}
      {menu && (<Menu.Item key="updatePassword"><LockOutlined />{t('update.password')}</Menu.Item>)}
      {/*{menu && (<Menu.Item key="settings"><SettingOutlined />{t('settings')}</Menu.Item>)}*/}
      {menu && <Menu.Divider />}
      {menu && (<Menu.Item key="logout"><LogoutOutlined />{t('logout')}</Menu.Item>)}
      {menu && (<Menu.Item><span>会员到期时间: {moment(currentUser.vipTime).format('YYYY-MM-DD')}</span></Menu.Item>)}
    </Menu>
  );

  return currentUser && currentUser.name ? (
    <HeaderDropdown overlay={menuHeaderDropdown}>
        <span className={styles['avatar']}>
          <Avatar size="small" src={currentUser.avatar} alt="avatar" style={{marginRight: 10}} />
          <span style={{color: "rgba(0,0,0,0.85"}}>{currentUser.name}</span>
        </span>
    </HeaderDropdown>
  ) : (
    <span>
        <Spin
          size="small"
          style={{
            marginLeft: 8,
            marginRight: 8,
          }}
        />
      </span>
  );

}
