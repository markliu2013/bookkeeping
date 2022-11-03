import { Space } from 'antd';
import Breadcrumb from '@/components/Breadcrumb';
import {spaceVProp} from "@/utils/var";
import OperationBar from './OperationBar';
import TotalAlert from './TotalAlert';
import RecordTable from './RecordTable';
import t from "@/utils/translate";


export default () => {

  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.bookkeeping'), t('menu.expense')]} />
      <OperationBar />
      <TotalAlert />
      <RecordTable />
    </Space>
  );
}
