import { useEffect } from "react";
import {Empty, Pagination, Space, Spin} from "antd";
import { useDispatch, useSelector } from "umi";
import {spaceVProp} from "@/utils/var";
import { usePaginationAndData } from "@/utils/hooks";
import { paginationChange } from "@/utils/util";
import ItemCard from "./ItemCard";


export default () => {

  const dispatch = useDispatch();

  const { queryResponse } = useSelector(state => state.assetAccounts);
  const queryLoading = useSelector(state => state.loading.effects['assetAccounts/query']);
  const [ dataAndPagination ] = usePaginationAndData(queryResponse);

  return (
    <Spin spinning={queryLoading} size="large">
      { dataAndPagination.data && dataAndPagination.data.length > 0 ?
        (
          <Space {...spaceVProp}>
            { dataAndPagination.data.map(item => <ItemCard key={item.id} account={item} />) }
            <Pagination {...dataAndPagination.pagination} onChange={paginationChange} />
          </Space>
        ) :
        (<Empty style={{ marginTop: 50 }} />)
      }
    </Spin>
  )
}
