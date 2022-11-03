import {useSelector} from "umi";
import {Card} from "antd";
import Line from '@/components/charts/Line';
import {useResponseData} from "@/utils/hooks";
import t from "@/utils/translate";

export default () => {

  const loading = useSelector(state => state.loading.effects['expenseIncomeTrendReports/query']);
  const { queryResponse } = useSelector(state => state.expenseIncomeTrendReports);
  const [data] = useResponseData(queryResponse);

  const cols = {
    month: {
      range: [0, 1]
    }
  };

  return (
    <Card title={t('menu.flow.trend')} bordered={false} bodyStyle={{padding: '40px 10px'}}>
      <Line loading={loading} data={data} scale={cols} height={600} padding={[ 20, 20, 80, 60 ]} />
    </Card>
  )

}
