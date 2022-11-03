import { useSelector } from 'umi';
import { Space } from "antd";
import {spaceVProp} from "@/utils/var";
import Breadcrumb from '@/components/Breadcrumb';
import OperationBar from './OperationBar';
import ExpenseCategoryTable from './ExpenseCategoryTable';
import IncomeCategoryTable from './IncomeCategoryTable';
import TagTable from './TagTable';
import PayeeTable from './PayeeTable';
import PayeeFilterBar from "./PayeeFilterBar";
import TagFilterBar from "./TagFilterBar";
import ExpenseCategoryFilterBar from "./ExpenseCategoryFilterBar";
import IncomeCategoryFilterBar from "./IncomeCategoryFilterBar";
import t from "@/utils/translate";


export default () => {

  const { currentCategoryType } = useSelector(state => state.categories);

  const tableSwitch = (type) => {
    switch(type) {
      case 1:
        return <ExpenseCategoryTable />;
      case 2:
        return <IncomeCategoryTable />;
      case 3:
        return <TagTable />;
      case 4:
        return <PayeeTable />;
    }
  }

  const filterSwitch = (type) => {
    switch(type) {
      case 1:
        return <ExpenseCategoryFilterBar />;
      case 2:
        return <IncomeCategoryFilterBar />;
      case 3:
        return <TagFilterBar />;
      case 4:
        return <PayeeFilterBar />;
    }
  }

  return (
    <Space  {...spaceVProp}>
      <Breadcrumb data={[t('menu.settings'), t('menu.category')]} />
      <OperationBar />
      { filterSwitch(currentCategoryType) }
      { tableSwitch(currentCategoryType) }
    </Space>
  );

}
