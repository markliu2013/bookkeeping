import { useEffect } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Button, Card, Col, Row, Statistic} from "antd";
import {ReloadOutlined} from "@ant-design/icons";
import { useResponseData } from '@/utils/hooks';
import t from "@/utils/translate";


export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'debtAccounts/sum' });
  }, []);
  const loading = useSelector(state => state.loading.effects['debtAccounts/sum']);
  const queryLoading = useSelector(state => state.loading.effects['debtAccounts/query']);
  const { sumResponse } = useSelector(state => state.debtAccounts);
  const [sum] = useResponseData(sumResponse);

  function refreshHandler() {
    dispatch({ type: 'debtAccounts/refresh' });
  }

  return (
    <Row gutter={16} align="middle">
      <Col span={4}>
        <Card bordered={false} size="small">
          <Statistic loading={loading} title={t('gross.balance')} value={sum.balance} valueStyle={{ color: "#2e2e2e" }} />
        </Card>
      </Col>
      <Col span={4}>
        <Card bordered={false} size="small">
          <Statistic loading={loading} title={t('gross.limit')} value={sum.limit} valueStyle={{ color: "#2e2e2e" }} />
        </Card>
      </Col>
      <Col span={4}>
        <Card bordered={false} size="small">
          <Statistic loading={loading} title={t('gross.remain.limit')} value={sum.remainLimit} valueStyle={{ color: "#2e2e2e" }} />
        </Card>
      </Col>
      <Col flex="auto" style={{ textAlign: "right" }}>
        <Button type="primary" size="large" loading={queryLoading || loading} icon={<ReloadOutlined />} onClick={ refreshHandler }>{t('reload')}</Button>
      </Col>
    </Row>
  )

}
