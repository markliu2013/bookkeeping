import { useEffect } from "react";
import { useDispatch, useSelector } from "umi";
import { useResponseData } from "@/utils/hooks";
import { Card, Tabs } from "antd";
import Bar from '@/components/charts/Bar';
import t from '@/utils/translate';


export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'dashboard/fetchIncomeTrend' });
  }, []);
  const loading = useSelector(state => state.loading.effects['dashboard/fetchIncomeTrend']);
  const { getIncomeTrendResponse } = useSelector(state => state.dashboard);
  const [data] = useResponseData(getIncomeTrendResponse);

  return (
    <Card title={t('income.trend')} bordered={false}>
      <Bar data={data} loading={loading} />
    </Card>
  )
}
