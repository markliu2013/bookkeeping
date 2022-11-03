import { useEffect } from 'react';
import {useDispatch, useIntl, useSelector} from 'umi';
import { Button, message, Table, Space, Modal } from "antd";
import { remove, run, recall } from '@/services/item';
import {tableProp} from "@/utils/var";
import {handleTableChange} from "@/utils/util";
import {usePaginationAndData} from "@/utils/hooks";
import OperationModal from "./OperationModal";
import t from "@/utils/translate";
import moment from "moment";


export default () => {

  const dispatch = useDispatch();

  const { queryResponse } = useSelector(state => state.items);
  const queryLoading = useSelector(state => state.loading.effects['items/query']);
  const [dataAndPagination] = usePaginationAndData(queryResponse);

  const updateHandler = (record) => {
    dispatch({ type: 'modal/show', payload: {component: OperationModal, type: 2, currentItem: record } });
  }

  const messageOperationSuccess = t('operation.success');
  const runHandler = async (record) => {
    const response = await run(record.id);
    if (response) {
      if (response.success) {
        message.success(messageOperationSuccess);
        dispatch({ type: 'items/query' });
      }
    }
  }

  const recallHandler = async (record) => {
    const response = await recall(record.id);
    if (response) {
      if (response.success) {
        message.success(messageOperationSuccess);
        dispatch({ type: 'items/query' });
      }
    }
  }

  const intl = useIntl();
  const deleteHandler = async (record) => {
    Modal.confirm({
      title: intl.formatMessage({id:'delete.confirm'}, { name: record.title }),
      onOk: async () => {
        const response = await remove(record.id);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          dispatch({ type: 'items/query' });
        }
      }
    });
  }

  const columns = [
    {
      title: '标题',
      dataIndex: 'title',
    },
    {
      title: '开始日期',
      dataIndex: 'startDate',
      sorter: true,
      width: 85,
      render: time => moment(time).format('YYYY-MM-DD')
    },
    {
      title: '结束日期',
      dataIndex: 'endDate',
      sorter: true,
      width: 85,
      render: time => time ? moment(time).format('YYYY-MM-DD') : ''
    },
    {
      title: '执行频率',
      dataIndex: 'repeatDescription',
      width: 95,
    },
    {
      title: '下次执行',
      dataIndex: 'nextDate',
      sorter: true,
      width: 85,
      render: time => time ? moment(time).format('YYYY-MM-DD') : ''
    },
    {
      title: '倒计时（天）',
      dataIndex: 'countDown',
      width: 85,
    },
    {
      title: '总次数',
      dataIndex: 'totalCount',
      sorter: true,
      width: 65,
    },
    {
      title: '已执行次数',
      dataIndex: 'runCount',
      sorter: true,
      width: 85,
    },
    {
      title: '剩余次数',
      dataIndex: 'remainCount',
      width: 65,
    },
    {
      title: t('notes'),
      dataIndex: 'notes',
    },
    {
      title: t('operation'),
      key: 'operation',
      width: 220,
      align: 'center',
      render: (_, record) => {
        return (
          <Space size="small">
            <Button size="small" disabled={record.totalCount <= record.runCount} onClick={() => runHandler(record)}>执行</Button>
            <Button size="small" disabled={record.runCount <= 0} onClick={() => recallHandler(record)}>撤回</Button>
            <Button size="small" onClick={() => updateHandler(record)}>{t('update')}</Button>
            <Button size="small" onClick={() => deleteHandler(record)}>{t('delete')}</Button>
          </Space>
        )
      }
    }
  ];

  return (
    <Table
      {...tableProp}
      size="small"
      columns={columns}
      dataSource={dataAndPagination.data}
      loading={queryLoading}
      pagination={dataAndPagination.pagination}
      onChange={handleTableChange}
    />
  );
}
