import {Col, Row, Space} from "antd";
import { spaceVProp } from "@/utils/var";
import Breadcrumb from "@/components/Breadcrumb";
import AssetBar from './AssetBar';
import TransactionTable from './TransactionTable';
import ExpenseTrend from './ExpenseTrend';
import IncomeTrend from './IncomeTrend';
import ExpenseCategory from './ExpenseCategory';
import IncomeCategory from './IncomeCategory';
import styles from './index.less';
import t from '@/utils/translate';


export default () => {
  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.report'), t('menu.overview')]} />
      <AssetBar />
      <TransactionTable />
      <Row gutter={8} className={styles['pie-row']}>
        <Col span={12}>
          <ExpenseCategory />
        </Col>
        <Col span={12}>
          <IncomeCategory />
        </Col>
      </Row>
      <Row gutter={8}>
        <Col span={24}>
          <ExpenseTrend />
        </Col>
      </Row>
      <Row gutter={8}>
        <Col span={24}>
          <IncomeTrend />
        </Col>
      </Row>
    </Space>
  );
}
