import {useDispatch, useIntl, useSelector} from 'umi';
import { Button, message, Table, Space, Modal, Switch } from "antd";
import { remove, toggle } from '@/services/category';
import { useResponseData } from "@/utils/hooks";
import {useEffect} from "react";
import {tableProp} from "@/utils/var";
import {searchTreeArray} from "@/utils/util";
import IncomeCategoryModal from './IncomeCategoryModal';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();

  useEffect(() => {
    dispatch({ type: 'categories/queryIncomeCategory' });
  }, []);

  const { queryIncomeCategoryResponse : queryResponse } = useSelector(state => state.categories);
  const queryLoading = useSelector(state => state.loading.effects['categories/queryIncomeCategory']);
  const [categoryTreeData, setCategoryTreeData] = useResponseData(queryResponse);

  const addHandler = (record, event) => {
    dispatch({ type: 'modal/show', payload: {component: IncomeCategoryModal, type: 1, currentItem: record }});
    event.stopPropagation();
  }

  const messageOperationSuccess = t('operation.success');
  const toggleHandler = async (record) => {
    // 乐观更新
    let newCategoryTreeData = JSON.parse(JSON.stringify(categoryTreeData));
    let node = searchTreeArray(newCategoryTreeData, record.id);
    if (node) node.enable = !node.enable;
    setCategoryTreeData(newCategoryTreeData);
    const response = await toggle(record.id);
    if (response) {
      if (response.success) {
        message.success(messageOperationSuccess);
        dispatch({ type: 'categories/queryIncomeCategory' });
        dispatch({ type: 'incomeCategory/refresh' });
      }
    }
  }

  const updateHandler = (record, event) => {
    dispatch({ type: 'modal/show', payload: {component: IncomeCategoryModal, type: 2, currentItem: record }});
    event.stopPropagation();
  }

  const intl = useIntl();
  const deleteHandler = async (record, event) => {
    Modal.confirm({
      title: intl.formatMessage({id:'delete.confirm'}, { name: record.name }),
      onOk: async () => {
        const response = await remove(record.id);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          dispatch({ type: 'categories/queryIncomeCategory' });
          dispatch({ type: 'incomeCategory/refresh' });
        }
      }
    });
    event.stopPropagation();
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
      render: (value, record) => <Switch onClick = { (_, event) => event.stopPropagation() } onChange={ () => toggleHandler(record) } checked={value} />
    },
    {
      title: t('operation'),
      key: 'operation',
      width: 150,
      align: 'center',
      render: (_, record) => {
        return (
          <Space size="small">
            <Button size="small" onClick={(event) => updateHandler(record, event)}>{t('update')}</Button>
            <Button size="small" disabled={!record.enable} onClick={(event) => addHandler(record, event)}>{t('new')}</Button>
            <Button size="small" onClick={(event) => deleteHandler(record, event)}>{t('delete')}</Button>
          </Space>
        )
      }
    }
  ];

  return (
    categoryTreeData && categoryTreeData.length > 0 && <Table
      {...tableProp}
      size="middle"
      columns={columns}
      dataSource={categoryTreeData}
      loading={queryLoading}
      expandable={{ expandRowByClick: true, defaultExpandAllRows: true }}
      pagination={false}
    />
  );
}
