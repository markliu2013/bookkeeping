import { useSelector } from 'umi';
import {useResultPaginationAndData} from '@/utils/hooks';
import {handleTableChange} from "@/utils/util";
import FlowRecordTable from '@/components/FlowRecordTable';

export default () => {

  const queryLoading = useSelector(state => state.loading.effects['audit/query']);
  const { queryResponse } = useSelector(state => state.audit);
  const [ dataAndPagination ] = useResultPaginationAndData(queryResponse);

  return (
    <FlowRecordTable
      bordered={true}
      data={dataAndPagination.data}
      pagination={dataAndPagination.pagination}
      queryLoading={queryLoading}
      tableChangeHandler={handleTableChange}
    />
  );

}
