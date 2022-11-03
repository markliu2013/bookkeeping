import {useEffect, useState} from "react";
import {useDispatch, useSelector} from "umi";
import { Card, Table } from 'antd';
import styles from './TransactionTable.less';
import t from '@/utils/translate';


export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'dashboard/fetchExpenseIncomeTable' });
  }, []);
  const loading = useSelector(state => state.loading.effects['dashboard/fetchExpenseIncomeTable']);
  const { getExpenseIncomeTableResponse } = useSelector(state => state.dashboard);
  const [data, setData] = useState([]);
  const expenseMessage = t('expense') + t('amount');
  const incomeMessage = t('income') + t('amount');
  const frequencyExpenseMessage = t('frequency.expense');
  const frequencyIncomeMessage = t('frequency.income');
  useEffect(() => {
    if (!getExpenseIncomeTableResponse)  return;
    if (getExpenseIncomeTableResponse.success) {
      const responseData = getExpenseIncomeTableResponse.data;
      setData(
        [
          {
            key: '1',
            name: expenseMessage,
            week: responseData[0][0],
            month: responseData[0][1],
            year: responseData[0][2],
            year2: responseData[0][3],
            week2: responseData[0][4],
            month2: responseData[0][5],
            year3: responseData[0][6],
          },
          {
            key: '2',
            name: incomeMessage,
            week: responseData[1][0],
            month: responseData[1][1],
            year: responseData[1][2],
            year2: responseData[1][3],
            week2: responseData[1][4],
            month2: responseData[1][5],
            year3: responseData[1][6],
          },
          {
            key: '3',
            name: frequencyExpenseMessage,
            week: responseData[2][0],
            month: responseData[2][1],
            year: responseData[2][2],
            year2: responseData[2][3],
            week2: responseData[2][4],
            month2: responseData[2][5],
            year3: responseData[2][6],
          },
          {
            key: '4',
            name: frequencyIncomeMessage,
            week: responseData[3][0],
            month: responseData[3][1],
            year: responseData[3][2],
            year2: responseData[3][3],
            week2: responseData[3][4],
            month2: responseData[3][5],
            year3: responseData[3][6],
          },
        ]
      );
    }
  }, [getExpenseIncomeTableResponse]);

  const columns = [
    {
      title: '',
      dataIndex: 'name',
      width: 150,
      className: 'name-col'
    },
    {
      title: t('this.week'),
      dataIndex: 'week',
    },
    {
      title: t('this.month'),
      dataIndex: 'month',
    },
    {
      title: t('this.year'),
      dataIndex: 'year',
    },
    {
      title: t('last.year'),
      dataIndex: 'year2',
    },
    {
      title: t('in.7.days'),
      dataIndex: 'week2',
    },
    {
      title: t('in.30.days'),
      dataIndex: 'month2',
    },
    {
      title: t('in.1.year'),
      dataIndex: 'year3',
    }
  ];

  return (
    <Card title={t('income.expense.table')} bordered={false} bodyStyle={{ padding: 0 }}>
      <Table
        loading={loading}
        size="small"
        className={styles['table']}
        columns={columns}
        dataSource={data}
        pagination={false} />
    </Card>
  );
}
