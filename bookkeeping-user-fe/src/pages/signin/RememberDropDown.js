// not used
import { Menu, Dropdown } from 'antd';
import { DownOutlined } from '@ant-design/icons';

const menu = (
  <Menu>
    <Menu.Item>不记住登录状态</Menu.Item>
    <Menu.Item>记住30分钟</Menu.Item>
    <Menu.Item>记住1小时</Menu.Item>
    <Menu.Item>记住1天</Menu.Item>
    <Menu.Item>记住3天</Menu.Item>
    <Menu.Item>记住7天</Menu.Item>
    <Menu.Item>记住30天</Menu.Item>
  </Menu>
);

const RememberDropDown = () => {
  return (
    <Dropdown overlay={menu}>
      <span className="ant-dropdown-link" style={{cursor: 'pointer'}}>
        不记住登录状态 <DownOutlined />
      </span>
    </Dropdown>
  );
};

export default RememberDropDown;