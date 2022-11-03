import { Space } from "antd";
import {spaceVProp} from "@/utils/var";
import Breadcrumb from "@/components/Breadcrumb";
import OperationBar from './OperationBar';
import Chart from './Chart';
import t from "@/utils/translate";

export default () => {
  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.report'), t('menu.asset.trend')]} />
      <OperationBar />
      <Chart />
    </Space>
  )
}
