import {useEffect} from "react";
import {history, useDispatch, useIntl, useSelector} from 'umi';
import { Button, message, Table, Space, Modal } from "antd";
import {tableProp} from "@/utils/var";
import { remove } from '@/services/log';
import {getTimeFormat, handleTableChange} from "@/utils/util";
import {usePaginationAndData} from "@/utils/hooks";
import t from "@/utils/translate";
import moment from "moment";

export default () => {

  const dispatch = useDispatch();

  const { queryResponse } = useSelector(state => state.logs);
  const queryLoading = useSelector(state => state.loading.effects['logs/query']);
  const [dataAndPagination] = usePaginationAndData(queryResponse);

  const intl = useIntl();
  const messageOperationSuccess = t('operation.success');
  const deleteHandler = async (record) => {
    Modal.confirm({
      title: intl.formatMessage({id:'delete.confirm'}),
      onOk: async () => {
        const response = await remove(record.id);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          dispatch({ type: 'logs/query', payload: history.location.query });
        }
      }
    });
  }

  const columns = [
    {
      title: t('flow.createTime'),
      dataIndex: 'createTime',
      sorter: true,
      width: 120,
      render: time => moment(time).format('YYYY-MM-DD')
    },
    {
      title:  t('asset.balance'),
      dataIndex: 'asset',
    },
    {
      title:  t('debt.balance'),
      dataIndex: 'debt',
    },
    {
      title: t('operation'),
      key: 'operation',
      align: 'center',
      width: 150,
      render: (_, record) => {
        return (
          <Space size="small">
            <Button size="small" onClick={() => deleteHandler(record)}>{t('delete')}</Button>
          </Space>
        )
      }
    }
  ];

  return (
    <Table
      {...tableProp}
      columns={columns}
      dataSource={dataAndPagination.data}
      loading={queryLoading}
      pagination={dataAndPagination.pagination}
      onChange={handleTableChange}
    />
  );
}
