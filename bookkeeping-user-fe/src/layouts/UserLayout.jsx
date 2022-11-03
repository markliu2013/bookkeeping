import { Layout } from "antd";
import Footer from '@/components/Footer';
import logo from '@/assets/logo.svg';
import t from '@/utils/translate';
import styles from './UserLayout.less';

export default (props) => {

  return (
    <Layout className={styles['container']}>
      <Layout.Content className={styles['content']}>
        <div className={styles['top']}>
          <div className={styles['header']}>
            <img alt="logo" className={styles['logo']} src={logo} />
            <span className={styles['title']}>Ant Design</span>
          </div>
          <div className={styles['desc']}>{t('app.title')}</div>
        </div>
        { props.children }
      </Layout.Content>
      <Layout.Footer><Footer /></Layout.Footer>
    </Layout>
  );
}
