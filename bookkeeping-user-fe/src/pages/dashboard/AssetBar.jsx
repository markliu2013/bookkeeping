import {useEffect} from "react";
import {Button, Card, Col, Row, Statistic} from "antd";
import {useDispatch, useSelector} from "umi";
import t from '@/utils/translate';
import {useResponseData} from "@/utils/hooks";

export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'dashboard/fetchAssetOverview' });
  }, []);
  const loading = useSelector(state => state.loading.effects['dashboard/fetchAssetOverview']);
  const { getAssetOverviewResponse } = useSelector(state => state.dashboard);
  const [assetOverview] = useResponseData(getAssetOverviewResponse);

  return (
    <Row gutter={8} align="middle">
      <Col span={4}>
        <Card bordered={false} size="small">
          <Statistic loading={loading} title={t('asset')} value={assetOverview.asset} valueStyle={{ color: "#2e2e2e" }} />
        </Card>
      </Col>
      <Col span={4}>
        <Card bordered={false} size="small">
          <Statistic loading={loading} title={t('debt')} value={assetOverview.debt} valueStyle={{ color: "#f1523a" }} />
        </Card>
      </Col>
      <Col span={4}>
        <Card bordered={false} size="small">
          <Statistic loading={loading} title={t('net.worth')} value={assetOverview.netWorth} valueStyle={{ color: "#14ba89" }} />
        </Card>
      </Col>
    </Row>
  );
}
