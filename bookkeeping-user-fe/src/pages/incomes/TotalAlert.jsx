import {useMemo} from "react";
import { useSelector } from 'umi';
import AlertTotalSearch from "@/components/AlertTotalSearch";
import {useResponseData} from "@/utils/hooks";
import t from '@/utils/translate';


export default () => {

  const { queryResponse } = useSelector(state => state.incomes);
  const [ responseData ] = useResponseData(queryResponse);
  const total = useMemo(() => {
    if (responseData.result) {
      return responseData.total;
    } else {
      return 0;
    }
  }, [responseData]);

  return (
    <AlertTotalSearch message={t('gross.income') + ': ' + total} />
  );

};
