import {useMemo} from "react";
import { useSelector } from 'umi';
import { Space } from 'antd';
import {useResponseData} from "@/utils/hooks";
import AlertTotalSearch from "@/components/AlertTotalSearch";
import t from '@/utils/translate';

export default () => {

  const { queryResponse } = useSelector(state => state.audit);
  const [ responseData ] = useResponseData(queryResponse);
  const total = useMemo(() => {
    if (responseData.result) {
      return [responseData.expense, responseData.income, responseData.surplus]
    } else {
      return [0, 0, 0]
    }
  }, [responseData]);

  return (
    <Space>
      <AlertTotalSearch message={t('gross.expense') + ': ' + total[0]} />
      <AlertTotalSearch message={t('gross.income') + ': ' + total[1]} />
      <AlertTotalSearch message={t('gross.surplus') + ': ' + total[2]} />
    </Space>
  );

};
