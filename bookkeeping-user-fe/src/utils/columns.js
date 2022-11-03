import {Switch} from "antd";
import moment from 'moment';
import FlagTag from '@/components/FlagTag';
import FlowStatusDisplay from '@/components/FlowStatusDisplay';
import t from '@/utils/translate';

export const createTimeCol = (timeFormat) => {
  return {
    title: t('flow.createTime'),
    dataIndex: 'createTime',
    sorter: true,
    width: 125,
    align: 'center',
    render: time => moment(time).format(timeFormat ? timeFormat : 'YYYY-MM-DD')
  }
}

export const amountCol = () => {
  return {
    title: t('amount'),
    dataIndex: 'amount',
    sorter: true,
    width: 70,
  }
}

export const balanceCol = () => {
  return {
    title:  t('account.balance'),
    dataIndex: 'balance',
    sorter: true,
    width: 80,
  }
}

export const statusCol = () => {
  return {
    title: t('flow.status'),
    dataIndex: 'status',
    sorter: true,
    width: 70,
    align: 'center',
    render: (_, record) => <FlowStatusDisplay data={record} />
  }
}

export const flowTypeCol = () => {
  return {
    title: t('flow.type'),
    dataIndex: 'typeName',
    // sorter: true,
    width: 58,
  }
}

export const accountIncludeCol = (toggleIncludeHandler) => {
  return {
    title: t('account.include'),
    dataIndex: 'include',
    sorter: true,
    width: 90,
    render: (value, record) => <Switch onChange={() => toggleIncludeHandler(record)} checked={value} />
  }
}

export const accountExpenseableCol = (toggleExpenseableHandler) => {
  return {
    title: t('expenseable'),
    dataIndex: 'expenseable',
    sorter: true,
    width: 70,
    render: (value, record) => <Switch onChange={() => toggleExpenseableHandler(record)} checked={value} />
  }
}

export const accountIncomeableCol = (toggleIncomeableHandler) => {
  return {
    title: t('incomeable'),
    dataIndex: 'incomeable',
    sorter: true,
    width: 70,
    render: (value, record) => <Switch onChange={() => toggleIncomeableHandler(record)} checked={value} />
  }
}

export const accountTransferToCol = (toggleTransferFromAbleHandler) => {
  return {
    title: t('transferToAble'),
    dataIndex: 'transferToAble',
    sorter: true,
    width: 70,
    render: (value, record) => <Switch onChange={() => toggleTransferFromAbleHandler(record)} checked={value} />
  }
}

export const accountTransferFromCol = (toggleTransferToAbleHandler) => {
  return {
    title: t('transferFromAble'),
    dataIndex: 'transferFromAble',
    sorter: true,
    width: 70,
    render: (value, record) => <Switch onChange={() => toggleTransferToAbleHandler(record)} checked={value} />
  }
}

export const accountEnableCol = (toggleHandler) => {
  return {
    title: t('is.enable'),
    dataIndex: 'enable',
    sorter: true,
    width: 80,
    render: (value, record) => <Switch onChange={() => toggleHandler(record)} checked={value} />
  }
}

export const categoryExpenseableCol = () => {
  return {
    title: t('expenseable'),
    dataIndex: 'expenseable',
    sorter: true,
    width: 120,
    render: value => <FlagTag value={value} />
  }
}

export const categoryIncomeableCol = () => {
  return {
    title: t('incomeable'),
    dataIndex: 'incomeable',
    sorter: true,
    width: 120,
    render: value => <FlagTag value={value} />
  }
}

export const categoryTransferableCol = () => {
  return {
    title: t('transferable'),
    dataIndex: 'transferable',
    sorter: true,
    width: 120,
    render: value => <FlagTag value={value} />
  }
}
