import {useSelector} from "umi";
import {Card, Row, Col, Button, Space, Descriptions, Collapse} from 'antd';
import { spaceVProp }  from '@/utils/var';
import AccountRecordTable from '@/components/AccountRecordTable';
import {showFlowModal} from '@/utils/flow';
import styles from './index.less';
import t from '@/utils/translate';


export default (props) => {

  const { account } = props;
  const { currentTime } = useSelector(state => state.checkingAccounts);

  function expenseHandler() {
    showFlowModal(1, 1, {accountId: account.id});
  }

  function incomeHandler() {
    showFlowModal(2, 1, {accountId: account.id});
  }

  function transferToHandler() {
    showFlowModal(3, 1, { toId: account.id });
  }

  function transferFromHandler() {
    showFlowModal(3, 1, { fromId: account.id });
  }

  function adjustBalanceHandler() {
    showFlowModal(4, 2, { ...account });
  }

  return (
    <Row gutter={16}>
      <Col span={24}>
          <Card title={account.name} bordered={false} size="small">
            <Space {...spaceVProp}>
              <Descriptions bordered={true} size="small" column={3}>
                <Descriptions.Item label={t('account.balance')}>{account.balance}</Descriptions.Item>
                <Descriptions.Item label={t('currency')}>{account.currencyCode}</Descriptions.Item>
                <Descriptions.Item label={t('account.include')}>{account.include ? t('yes') : t('no')}</Descriptions.Item>
              </Descriptions>
              <Space size="small">
                <Button disabled={!account.expenseable} size="small" type="primary" onClick={expenseHandler}>{t('expense')}</Button>
                <Button disabled={!account.incomeable} size="small" type="primary" onClick={incomeHandler}>{t('income')}</Button>
                <Button disabled={!account.transferToAble} size="small" type="primary" onClick={transferToHandler}>{t('transfer.to')}</Button>
                <Button disabled={!account.transferFromAble} size="small" type="primary" onClick={transferFromHandler}>{t('transfer.from')}</Button>
                <Button size="small" type="primary" onClick={adjustBalanceHandler}>{t('adjust.balance')}</Button>
              </Space>
              <Collapse className={styles['item-card-collapse']}>
                <Collapse.Panel key={1} header={t('flow.record')}>
                  <AccountRecordTable accountId={account.id} currentTime={currentTime} />
                </Collapse.Panel>
              </Collapse>
            </Space>
          </Card>
      </Col>
    </Row>
  );
}
