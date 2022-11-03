import {useEffect, useState} from "react";
import {useDispatch, useSelector} from "umi";
import { Card } from "antd";
import {useResponseData} from "@/utils/hooks";
import Pie from '@/components/charts/Pie';
import t from '@/utils/translate';

export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'balanceSheetReports/getDebt' });
  }, []);
  const loading = useSelector(state => state.loading.effects['balanceSheetReports/getDebt']);
  const { getDebtResponse } = useSelector(state => state.balanceSheetReports);
  const [data] = useResponseData(getDebtResponse);

  return (
    <Card title={t('report.debt.category')} bordered={false} bodyStyle={{padding: '40px 10px'}} style={{height:'100%'}}>
      <Pie data={data} loading={loading} />
    </Card>
  )

}
