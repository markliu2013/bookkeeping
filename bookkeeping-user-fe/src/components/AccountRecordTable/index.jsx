import { useEffect, useState } from "react";
import { useResultPaginationAndData } from '@/utils/hooks';
import { tableChangeQueryFormat } from "@/utils/util";
import {query as queryFlows} from '@/services/flow'
import FlowRecordTable from '@/components/FlowRecordTable';

export default (props) => {

  // currentTime刷新使用
  const { accountId, currentTime } = props;

  const [queryResponse, setQueryResponse] = useState();
  const [ dataAndPagination ] = useResultPaginationAndData(queryResponse);
  const [loading, setLoading] = useState(false);
  async function fetchData(id, query) {
    setLoading(true);
    let response = await queryFlows(Object.assign({accountId: id}, query));
    setQueryResponse(response);
    setLoading(false);
  }

  function handleTableChange(pagination, _, sorter) {
    fetchData(accountId, tableChangeQueryFormat(pagination, sorter));
  }

  useEffect(() => {
    fetchData(accountId, dataAndPagination.pagination.current, dataAndPagination.pagination.pageSize);
  }, [accountId, currentTime]);

  return (
    <FlowRecordTable
      bordered={false}
      data={dataAndPagination.data}
      pagination={dataAndPagination.pagination}
      queryLoading={loading}
      tableChangeHandler={handleTableChange}
    />
  );
}
