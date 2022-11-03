import { Space } from 'antd';
import {spaceVProp} from "@/utils/var";
import Breadcrumb from '@/components/Breadcrumb';
import OperationBar from './OperationBar';
import RecordTable from './RecordTable';
import TotalAlert from "./TotalAlert";
import t from '@/utils/translate';


export default () => {
  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.bookkeeping'), t('menu.income')]} />
      <OperationBar />
      <TotalAlert />
      <RecordTable />
    </Space>
  );
}
