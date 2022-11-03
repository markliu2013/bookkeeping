import {Space} from "antd";
import {spaceVProp} from "@/utils/var";
import Breadcrumb from "@/components/Breadcrumb";
import OperationBar from './OperationBar';
import RecordTable from './RecordTable';
import t from "@/utils/translate";


export default () => {

  return (
    <Space {...spaceVProp} size="large">
      <Breadcrumb data={[t('menu.settings'), t('menu.group')]} />
      <OperationBar />
      <RecordTable />
    </Space>
  );
}
