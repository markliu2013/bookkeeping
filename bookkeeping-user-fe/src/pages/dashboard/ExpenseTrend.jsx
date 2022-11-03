import { useEffect } from "react";
import { useDispatch, useSelector } from "umi";
import { useResponseData } from "@/utils/hooks";
import { Card, Tabs } from "antd";
import Bar from '@/components/charts/Bar';
import t from '@/utils/translate';


export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'dashboard/fetchExpenseTrend' });
  }, []);
  const loading = useSelector(state => state.loading.effects['dashboard/fetchExpenseTrend']);
  const { getExpenseTrendResponse } = useSelector(state => state.dashboard);
  const [data] = useResponseData(getExpenseTrendResponse);

  return (
    <Card title={t('expense.trend')} bordered={false}>
      <Bar data={data} loading={loading} />
    </Card>
  )
}
