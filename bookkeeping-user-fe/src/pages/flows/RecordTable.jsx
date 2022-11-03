import { useSelector } from 'umi';
import {useResultPaginationAndData} from '@/utils/hooks';
import {handleTableChange} from "@/utils/util";
import FlowRecordTable from '@/components/FlowRecordTable';

export default () => {

  const queryLoading = useSelector(state => state.loading.effects['flows/query']);
  const { queryResponse } = useSelector(state => state.flows);
  const [ dataAndPagination ] = useResultPaginationAndData(queryResponse);

  return (
    <FlowRecordTable
      bordered={true}
      noBook={true}
      data={dataAndPagination.data}
      pagination={dataAndPagination.pagination}
      queryLoading={queryLoading}
      tableChangeHandler={handleTableChange}
    />
  );

}
