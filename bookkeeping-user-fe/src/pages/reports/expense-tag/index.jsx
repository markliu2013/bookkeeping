import { Space } from "antd";
import {spaceVProp} from "@/utils/var";
import Breadcrumb from "@/components/Breadcrumb";
import OperationBar from './OperationBar';
import TagPie from "./TagPie";
import t from "@/utils/translate";

export default () => {
  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.report'), t('menu.expense.tag.reports')]} />
      <OperationBar />
      <TagPie />
    </Space>
  )
}
