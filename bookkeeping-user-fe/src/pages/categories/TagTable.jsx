import {useEffect} from "react";
import {useDispatch, useIntl, useSelector} from 'umi';
import {Button, message, Table, Space, Modal, Switch} from "antd";
import {tableProp} from "@/utils/var";
import {searchTreeArray, tableChangeQueryFormat} from "@/utils/util";
import { categoryExpenseableCol, categoryIncomeableCol, categoryTransferableCol } from '@/utils/columns';
import { remove, toggle } from '@/services/tag';
import {useResponseData} from '@/utils/hooks';
import TagModal from './TagModal';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();

  const { queryTagResponse : queryResponse } = useSelector(state => state.categories);
  const queryLoading = useSelector(state => state.loading.effects['categories/queryTag']);
  const [tagTreeData, setTagTreeData] = useResponseData(queryResponse);

  useEffect(() => {
    dispatch({ type: 'categories/queryTag' });
  }, []);

  function refresh() {
    dispatch({ type: 'categories/queryTag' });
    dispatch({ type: 'tag/refresh'});
  }

  const messageOperationSuccess = t('operation.success');
  const toggleHandler = async (record) => {
    // 乐观更新
    let newTreeData = JSON.parse(JSON.stringify(tagTreeData));
    let node = searchTreeArray(newTreeData, record.id);
    if (node) node.enable = !node.enable;
    setTagTreeData(newTreeData);
    const response = await toggle(record.id);
    if (response && response.success) {
      message.success(messageOperationSuccess);
      refresh();
    }
  }

  const addHandler = (record, event) => {
    dispatch({ type: 'modal/show', payload: {component: TagModal, type: 1, currentItem: record }});
    event.stopPropagation();
  }

  const updateHandler = (record, event) => {
    dispatch({ type: 'modal/show', payload: {component: TagModal, type: 2, currentItem: record }});
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
          refresh();
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
      sorter: true,
      render: (value, record) => <Switch onClick = { (_, e) => e.stopPropagation() } onChange={() => toggleHandler(record)} checked={value} />
    },
    categoryExpenseableCol(),
    categoryIncomeableCol(),
    categoryTransferableCol(),
    {
      title: t('operation'),
      key: 'operation',
      width: 160,
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
    tagTreeData && tagTreeData.length > 0 && <Table
      {...tableProp}
      size="middle"
      columns={columns}
      dataSource={tagTreeData}
      loading={queryLoading}
      expandable={{ expandRowByClick: true, defaultExpandAllRows: false }}
      pagination={false}
    />
  );
}
