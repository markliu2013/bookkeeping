import {useEffect} from "react";
import {useDispatch, useIntl, useSelector} from 'umi';
import {Button, message, Table, Space, Modal, Switch} from "antd";
import {tableProp} from "@/utils/var";
import { tableChangeQueryFormat } from "@/utils/util";
import { categoryExpenseableCol, categoryIncomeableCol } from '@/utils/columns';
import { remove, toggle } from '@/services/payee';
import { usePaginationAndData } from '@/utils/hooks';
import PayeeModal from './PayeeModal';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();

  const { queryPayeeResponse : queryResponse } = useSelector(state => state.categories);
  const queryLoading = useSelector(state => state.loading.effects['categories/queryPayee']);
  const [ dataAndPagination ] = usePaginationAndData(queryResponse);
  const { payeePagination : pagination, payeeSorter : sorter, payeeQueryData: query } = useSelector(state => state.categories);

  useEffect(() => {
    dispatch({ type: 'categories/queryPayee' });
  }, []);

  function tableChangeHandler(pagination, _, sorter) {
    dispatch({ type: 'categories/updateState', payload: {payeePagination: pagination, payeeSorter: sorter} });
    dispatch({ type: 'categories/queryPayee', payload: { ...tableChangeQueryFormat(pagination, sorter), ...query }});
  }

  function refresh(response) {
    dispatch({ type: 'categories/queryPayee', payload: {...tableChangeQueryFormat(pagination, sorter), ...query }});
    dispatch({ type: 'payee/refresh', payload: { ...response.data } });
  }

  const messageOperationSuccess = t('operation.success');
  const toggleHandler = async (record) => {
    const response = await toggle(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh(response);
    }
  }

  const updateHandler = (record) => {
    dispatch({ type: 'modal/show', payload: {component: PayeeModal, type: 2, currentItem: record }});
  }

  const intl = useIntl();
  const deleteHandler = async (record) => {
    Modal.confirm({
      title: intl.formatMessage({id:'delete.confirm'}, { name: record.name }),
      onOk: async () => {
        const response = await remove(record.id);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          refresh(response);
        }
      }
    });
  }

  const columns = [
    {
      title: t('name'),
      dataIndex: 'name',
    },
    {
      title: t('notes'),
      dataIndex: 'notes',
    },
    {
      title: t('is.enable'),
      dataIndex: 'enable',
      width: 150,
      render: (value, record) => <Switch onChange={() => toggleHandler(record)} checked={value} />
    },
    categoryExpenseableCol(),
    categoryIncomeableCol(),
    {
      title: t('operation'),
      key: 'operation',
      width: 120,
      align: 'center',
      render: (_, record) => {
        return (
          <Space size="small">
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
      size="middle"
      columns={columns}
      dataSource={dataAndPagination.data}
      rowKey={record => record.id}
      loading={queryLoading}
      pagination={dataAndPagination.pagination}
      onChange={tableChangeHandler}
    />
  );
}
