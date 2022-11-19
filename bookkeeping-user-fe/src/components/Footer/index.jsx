import { Space } from 'antd';
import t from '@/utils/translate';

import styles from './index.less';

export default () => {
  return (
    <Space className={styles['footer']} direction="vertical" size="small" style={{ width:"100%" }}>
      <div className={styles['footer-link']}>
        <Space size="small">
          <a href="#">{t('footer.download.ios')}</a>
          <a href="#">{t('footer.download.andriod')}</a>
          <a href="#">{t('footer.download.weibo')}</a>
          <a href="#">{t('footer.download.zhihu')}</a>
          <a href="#">{t('footer.download.contact')}</a>
          <a href="#">{t('footer.download.about')}</a>
        </Space>
      </div>
      <div>&copy; {new Date().getFullYear()} {t('company.name')}版权所有&nbsp;&nbsp;<a target="_blank" href="https://beian.miit.gov.cn/">{t('footer.no')}</a> v1.0.5</div>
    </Space>
  );
};
