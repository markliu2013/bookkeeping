import { useEffect } from 'react';
import {useDispatch, useIntl, useSelector} from 'umi';
import {Button, Descriptions, message, Modal, Space, Table} from "antd";
import { usePaginationAndData } from "@/utils/hooks";
import { remove, toggle, toggleInclude, toggleExpenseable, toggleIncomeable, toggleTransferFromAble, toggleTransferToAble } from '@/services/account';
import { tableChangeQueryFormat } from "@/utils/util";
import {showFlowModal} from '@/utils/flow';
import CheckingAccountModal from "./CheckingAccountModal";
import t from "@/utils/translate";
import {
  accountEnableCol,
  accountExpenseableCol,
  accountIncludeCol,
  accountIncomeableCol, accountTransferFromCol,
  accountTransferToCol,
  balanceCol
} from "@/utils/columns";
import {tableProp} from "@/utils/var";


export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'accounts/queryCheckingAccount' });
  }, []);

  const { queryCheckingAccountResponse: queryResponse } = useSelector(state => state.accounts);
  const queryLoading = useSelector(state => state.loading.effects['accounts/queryCheckingAccount']);
  const [ dataAndPagination ] = usePaginationAndData(queryResponse);
  const { checkingAccountPagination : pagination, checkingAccountSorter : sorter } = useSelector(state => state.accounts);

  const { defaultGroup } = useSelector(state => state.session);
  useEffect(() => {
    if (!defaultGroup) dispatch({ type: 'session/fetchSession' });
  }, []);

  function tableChangeHandler(pagination, _, sorter) {
    dispatch({ type: 'accounts/updateState', payload: {checkingAccountPagination: pagination, checkingAccountSorter: sorter} });
    dispatch({ type: 'accounts/queryCheckingAccount', payload: tableChangeQueryFormat(pagination, sorter) });
  }

  function refresh() {
    dispatch({ type: 'accounts/queryCheckingAccount', payload: tableChangeQueryFormat(pagination, sorter) });
    dispatch({ type: 'account/refresh'});
  }

  const messageOperationSuccess = t('operation.success');
  const toggleHandler = async (record) => {
    const response = await toggle(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh();
    }
  }
  const toggleIncludeHandler = async (record) => {
    const response = await toggleInclude(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh();
    }
  }
  const toggleExpenseableHandler = async (record) => {
    const response = await toggleExpenseable(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh();
    }
  }
  const toggleIncomeableHandler = async (record) => {
    const response = await toggleIncomeable(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh();
    }
  }
  const toggleTransferFromAbleHandler = async (record) => {
    const response = await toggleTransferFromAble(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh();
    }
  }
  const toggleTransferToAbleHandler = async (record) => {
    const response = await toggleTransferToAble(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh();
    }
  }

  const updateHandler = (record) => {
    dispatch({ type: 'modal/show', payload: {component: CheckingAccountModal, type: 2, currentItem: record }});
  }

  const adjustBalanceHandler = (record) => {
    showFlowModal(4, 2, {...record});
  }

  const intl = useIntl();
  const deleteHandler = async (record) => {
    Modal.confirm({
      title: intl.formatMessage({id:'delete.confirm'}, { name: record.name }),
      onOk: async () => {
        const response = await remove(record.id);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          refresh();
        }
      }
    });
  }

  const columns = [
    {
      title: t('name'),
      dataIndex: 'name',
    },
    balanceCol(),
    {
      title: t('currency'),
      dataIndex: 'currencyCode',
      sorter: true,
      width: 70,
    },
    {
      title: t('convertCurrency') + (defaultGroup ? defaultGroup.defaultCurrencyCode : ''),
      dataIndex: 'convertedBalance',
      width: 80,
    },
    accountIncludeCol(toggleIncludeHandler),
    accountExpenseableCol(toggleExpenseableHandler),
    accountIncomeableCol(toggleIncomeableHandler),
    accountTransferToCol(toggleTransferToAbleHandler),
    accountTransferFromCol(toggleTransferFromAbleHandler),
    accountEnableCol(toggleHandler),
    {
      title: t('operation'),
      key: 'operation',
      align: 'center',
      width: 170,
      render: (_, record) => {
        return (
          <Space size="small">
            <Button size="small" onClick={() => updateHandler(record)}>{t('update')}</Button>
            <Button size="small" onClick={() => deleteHandler(record)}>{t('delete')}</Button>
            <Button size="small" onClick={() => adjustBalanceHandler(record)}>{t('adjust.balance')}</Button>
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
      expandable={{
        expandedRowRender: record => <Descriptions size="small" bordered column={3}>
          <Descriptions.Item label={t('account.card.no')}>{record.no ? record.no : t('null')}</Descriptions.Item>
          <Descriptions.Item label={t('account.initial.balance')}>{record.initialBalance}</Descriptions.Item>
          <Descriptions.Item label={t('notes')}>{record.notes ? record.notes : t('null')}</Descriptions.Item>
        </Descriptions>,
      }}
      dataSource={dataAndPagination.data}
      pagination={dataAndPagination.pagination}
      loading={queryLoading}
      onChange={tableChangeHandler}
    />
  );
}
