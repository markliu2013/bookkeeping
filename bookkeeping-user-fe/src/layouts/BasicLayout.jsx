import {useState} from "react";
import { Layout, Row, Col, Badge } from 'antd';
import {SelectLang} from 'umi';
import { MenuFoldOutlined, MenuUnfoldOutlined, QuestionCircleOutlined, MessageOutlined } from '@ant-design/icons';
import Avatar from '@/components/AvatarDropdown';
import PrimaryMenu from '@/components/PrimaryMenu';
import Footer from '@/components/Footer';
import ModalRoot from '@/components/ModalRoot';
import FlowButtons from '@/components/FlowButtons';
import styles from './BasicLayout.less';

export default (props) => {

  const [collapsed, setCollapsed] = useState(false);

  return (
    <Layout style={{ minHeight: '100vh' }} className={styles['page-layout']}>
      <Layout.Sider trigger={null} collapsible collapsed={collapsed} className={styles['layout-sider']}>
        <div className={styles['logo']}>九快计账</div>
        <PrimaryMenu />
      </Layout.Sider>
      <Layout className={styles['layout']}>
        <Layout.Header className={styles['header']}>
          <Row>
            <Col flex="1 1 0%" style={{textAlign: 'center'}}>
              <div className={styles['button']} onClick={()=>setCollapsed(!collapsed)}>
                {collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
              </div>
              <FlowButtons />
            </Col>
            <Col style={{paddingRight: 20}}>
              <a className={styles['button']} href="http://docs.jz.jiukuaitech.com/" target="_blank"><QuestionCircleOutlined /></a>
              {/*<div className={styles['button']}>*/}
              {/*  <Badge count={11} style={{ boxShadow: 'none'}}>*/}
              {/*    <MessageOutlined style={{fontSize: 16, padding: "5px 5px 5px 0"}} />*/}
              {/*  </Badge>*/}
              {/*</div>*/}
              <Avatar menu />
              <SelectLang />
            </Col>
          </Row>
        </Layout.Header>
        <Layout.Content className={styles['content']}>{props.children}</Layout.Content>
        <Layout.Footer><Footer /></Layout.Footer>
        <ModalRoot />
      </Layout>
    </Layout>
  );

}
