import { Space } from 'antd';
import { spaceVProp }  from '@/utils/var';
import Breadcrumb from "@/components/Breadcrumb";
import GeneralBar from './GeneralBar';
import List from './List';
import t from '@/utils/translate';

export default () => {

  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.account.list'), t('menu.debt.account')]} />
      <GeneralBar />
      <List />
    </Space>
  );
}
