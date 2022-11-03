import { Space } from 'antd';
import {spaceVProp} from '@/utils/var';
import Breadcrumb from '@/components/Breadcrumb';
import OperationBar from './OperationBar';
import TotalAlert from './TotalAlert';
import RecordTable from './RecordTable';
import t from '@/utils/translate';

export default () => {

  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.bookkeeping'), t('menu.audit')]} />
      <OperationBar />
      <TotalAlert />
      <RecordTable />
    </Space>
  );

}
