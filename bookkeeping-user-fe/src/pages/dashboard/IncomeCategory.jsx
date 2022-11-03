import {useEffect, useState} from "react";
import {useDispatch, useSelector} from "umi";
import { Card } from "antd";
import CardExtra from './CardExtra';
import {radioValueToTimeRange} from "@/utils/util";
import {useResponseData} from "@/utils/hooks";
import Pie from '@/components/charts/Pie';
import t from '@/utils/translate';

export default () => {

  const dispatch = useDispatch();

  const [timeRange, setTimeRange] = useState(7);
  function timeRangeChangeHanlder(value) {
    setTimeRange(value);
  }

  useEffect(() => {
    const rangeValues = radioValueToTimeRange(timeRange);
    dispatch({
      type: 'dashboard/fetchIncomeCategory',
      payload: { start: rangeValues[0].valueOf(), end: rangeValues[1].valueOf() }
    });
  }, [timeRange]);
  const loading = useSelector(state => state.loading.effects['dashboard/fetchIncomeCategory']);
  const { getIncomeCategoryResponse } = useSelector(state => state.dashboard);
  const [data] = useResponseData(getIncomeCategoryResponse);

  return (
    <Card title={t('income.category')} bordered={false} bodyStyle={{padding: '40px 10px'}} extra={<CardExtra value={timeRange} onChange={timeRangeChangeHanlder} />}>
      <Pie data={data} loading={loading} />
    </Card>
  )

}
