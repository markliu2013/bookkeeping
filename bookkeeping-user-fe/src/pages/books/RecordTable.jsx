import {useEffect} from "react";
import {useDispatch, useIntl, useSelector} from 'umi';
import {Button, message, Table, Space, Modal, Switch} from "antd";
import { remove, toggle } from '@/services/book';
import { setDefaultBook } from '@/services/user';
import {tableProp} from "@/utils/var";
import { handleTableChange } from "@/utils/util";
import {usePaginationAndData} from "@/utils/hooks";
import FlagTag from '@/components/FlagTag';
import OperationModal from '@/pages/books/OperationModal';
import ConfigModal from '@/pages/books/ConfigModal';
import t from "@/utils/translate";


export default () => {

  const dispatch = useDispatch();

  const { defaultBook } = useSelector(state => state.session);
  useEffect(() => {
    if (!defaultBook) dispatch({ type: 'session/fetchSession' });
  }, []);

  const { queryResponse } = useSelector(state => state.books);
  const queryLoading = useSelector(state => state.loading.effects['books/query']);
  const [dataAndPagination] = usePaginationAndData(queryResponse);

  const updateHandler = (record) => {
    dispatch({ type: 'modal/show', payload: {component: OperationModal, type: 2, currentItem: record } });
  }

  const configHandler = (record) => {
    dispatch({ type: 'modal/show', payload: {component: ConfigModal, type: 2, currentItem: record } });
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
          dispatch({ type: 'books/query' });
        }
      }
    });
  }

  const setDefaultHandler = async (record) => {
    const response = await setDefaultBook(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      window.location.reload();
    }
  }

  const toggleHandler = async (record) => {
    const response = await toggle(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      dispatch({ type: 'books/query' });
    }
  }

  const columns = [
    {
      title: t('book.name'),
      dataIndex: 'name',
    },
    {
      title: t('default.currency'),
      dataIndex: 'defaultCurrencyCode',
      width: 70,
    },
    {
      title: t('book.group'),
      dataIndex: 'group',
      render: value => <>{value ? value.name : null}</>
    },
    {
      title: t('book.description.eable'),
      dataIndex: 'descriptionEnable',
      width: 90,
      render: value => <FlagTag value={value} />
    },
    {
      title: t('book.time.eable'),
      dataIndex: 'timeEnable',
      width: 90,
      render: value => <FlagTag value={value} />
    },
    {
      title: t('book.image.eable'),
      dataIndex: 'imageEnable',
      width: 90,
      render: value => <FlagTag value={value} />
    },
    {
      title: t('book.default.expense.account'),
      dataIndex: 'defaultExpenseAccount',
      render: value => <>{value ? value.name : null}</>
    },
    {
      title: t('book.default.income.account'),
      dataIndex: 'defaultIncomeAccount',
      render: value => <>{value ? value.name : null}</>
    },
    {
      title: t('book.default.expense.category'),
      dataIndex: 'defaultExpenseCategory',
      render: value => <>{value ? value.name : null}</>
    },
    {
      title: t('book.default.income.category'),
      dataIndex: 'defaultIncomeCategory',
      render: value => <>{value ? value.name : null}</>
    },
    {
      title: t('book.default.transfer.from.account'),
      dataIndex: 'defaultTransferFromAccount',
      render: value => <>{value ? value.name : null}</>
    },
    {
      title: t('book.default.transfer.to.account'),
      dataIndex: 'defaultTransferToAccount',
      render: value => <>{value ? value.name : null}</>
    },
    {
      title: t('is.enable'),
      dataIndex: 'enable',
      width: 80,
      render: (value, record) => <Switch disabled={defaultBook && record.id === defaultBook.id} onChange={() => toggleHandler(record)} checked={value} />
    },
    {
      title: t('operation'),
      key: 'operation',
      align: 'center',
      width: 230,
      render: (_, record) => {
        return (
          <Space size="small">
            <Button size="small" onClick={() => updateHandler(record)}>{t('update')}</Button>
            <Button size="small" disabled={defaultBook && record.id === defaultBook.id} onClick={() => deleteHandler(record)}>{t('delete')}</Button>
            <Button size="small" disabled={!defaultBook || record.id !== defaultBook.id} onClick={() => configHandler(record)}>{t('config')}</Button>
            <Button size="small" disabled={defaultBook && record.id === defaultBook.id} onClick={() => setDefaultHandler(record)}>{t('set.default')}</Button>
          </Space>
        )
      }
    }
  ];

  return (
    <Table
      {...tableProp}
      rowClassName={record => {
        if (defaultBook && record.id === defaultBook.id) return 'table-color-default';
      }}
      size="small"
      columns={columns}
      dataSource={dataAndPagination.data}
      loading={queryLoading}
      pagination={dataAndPagination.pagination}
      onChange={handleTableChange}
    />
  );
}
