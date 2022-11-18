import { useEffect } from 'react';
import {useDispatch, useIntl, useSelector} from 'umi';
import { Button, message, Table, Space, Modal } from "antd";
import { remove } from '@/services/group';
import { setDefaultGroup } from "@/services/user";
import {tableProp} from "@/utils/var";
import {handleTableChange} from "@/utils/util";
import {usePaginationAndData} from "@/utils/hooks";
import OperationModal from "./OperationModal";
import t from "@/utils/translate";


export default () => {

  const dispatch = useDispatch();

  const { defaultGroup } = useSelector(state => state.session);
  useEffect(() => {
    if (!defaultGroup) dispatch({ type: 'session/fetchSession' });
  }, [defaultGroup]);

  const { queryResponse } = useSelector(state => state.groups);
  const queryLoading = useSelector(state => state.loading.effects['groups/query']);
  const [dataAndPagination] = usePaginationAndData(queryResponse);

  const updateHandler = (record) => {
    dispatch({ type: 'modal/show', payload: {component: OperationModal, type: 2, currentItem: record } });
  }

  const intl = useIntl();
  const messageOperationSuccess = t('operation.success');
  const deleteHandler = async (record) => {
    Modal.confirm({
      title: intl.formatMessage({id:'delete.confirm'}, { name: record.name }),
      onOk: async () => {
        const response = await remove(record.id);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          dispatch({ type: 'groups/query' });
        }
      }
    });
  }

  const setDefaultHandler = async (record) => {
    const response = await setDefaultGroup(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      window.location.reload();
    }
  }

  const columns = [
    {
      title: t('group.name'),
      dataIndex: 'name',
    },
    {
      title: t('default.currency'),
      dataIndex: 'defaultCurrencyCode',
      width: 70,
    },
    {
      title: t('notes'),
      dataIndex: 'notes',
    },
    {
      title: t('operation'),
      key: 'operation',
      width: 190,
      align: 'center',
      render: (_, record) => {
        return (
          <Space size="small">
            <Button size="small" onClick={() => updateHandler(record)}>{t('update')}</Button>
            <Button size="small" disabled={defaultGroup && record.id === defaultGroup.id} onClick={() => deleteHandler(record)}>{t('delete')}</Button>
            <Button size="small" disabled={defaultGroup && record.id === defaultGroup.id} onClick={() => setDefaultHandler(record)}>{t('set.default')}</Button>
          </Space>
        )
      }
    }
  ];

  return (
    <Table
      {...tableProp}
      rowClassName={record => {
        if (defaultGroup && record.id === defaultGroup.id) return 'table-color-default';
      }}
      size="middle"
      columns={columns}
      dataSource={dataAndPagination.data}
      loading={queryLoading}
      pagination={dataAndPagination.pagination}
      onChange={handleTableChange}
    />
  );
}
