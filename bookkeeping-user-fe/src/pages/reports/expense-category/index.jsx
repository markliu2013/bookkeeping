import { Space } from "antd";
import {spaceVProp} from "@/utils/var";
import Breadcrumb from "@/components/Breadcrumb";
import OperationBar from './OperationBar';
import CategoryPie from "./CategoryPie";
import t from "@/utils/translate";

export default () => {
  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.report'), t('menu.expense.category.reports')]} />
      <OperationBar />
      <CategoryPie />
    </Space>
  )
}
