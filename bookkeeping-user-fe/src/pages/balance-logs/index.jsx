import {Space} from "antd";
import {spaceVProp} from "@/utils/var";
import Breadcrumb from "@/components/Breadcrumb";
import RecordTable from './RecordTable';
import OperationBar from './OperationBar';
import t from "@/utils/translate";

export default () => {

  return (
    <Space {...spaceVProp} size="large">
      <Breadcrumb data={[t('menu.account.list'), t('balance.log')]} />
      <OperationBar />
      <RecordTable />
    </Space>
  );

}
