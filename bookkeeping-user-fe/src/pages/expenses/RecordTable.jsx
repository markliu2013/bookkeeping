import {history, useDispatch, useSelector} from 'umi';
import {Table, Space, message, Modal, Descriptions, Dropdown, Menu, Tooltip} from 'antd';
import { DownOutlined } from '@ant-design/icons';
import { remove, confirm } from '@/services/flow';
import {useResultPaginationAndData, useImageEnable, useDescriptionEnable, useTimeFormat} from '@/utils/hooks';
import { handleTableChange } from "@/utils/util";
import {showFlowModal, imageHandler} from '@/utils/flow';
import { tableProp }  from '@/utils/var';
import {createTimeCol, amountCol, statusCol} from '@/utils/columns';
import FlowTagDisplay from '@/components/FlowTagDisplay';
import t from '@/utils/translate';

export default () => {

  const dispatch = useDispatch();
  const { queryResponse } = useSelector(state => state.expenses);
  const queryLoading = useSelector(state => state.loading.effects['expenses/query']);
  const [ dataAndPagination ] = useResultPaginationAndData(queryResponse);
  const imageEnable = useImageEnable();
  const descriptionEnable = useDescriptionEnable();
  const timeFormat = useTimeFormat();

  let columns = [];
  if (descriptionEnable) {
    columns.push({
      title: t('description'),
      dataIndex: 'description',
    });
  }
  columns = columns.concat(
    [
      amountCol(),
      createTimeCol(timeFormat),
      {
        title: t('category'),
        dataIndex: 'categoryName',
      },
      {
        title: t('account'),
        dataIndex: 'accountName',
      },
      {
        title: t('flow.tag'),
        dataIndex: 'tags',
        render: (tags, record) => <>{tags.map(i => <FlowTagDisplay record={record} data={i} key={i.tagId} />)}</>
      },
      {
        title: t('flow.payee'),
        dataIndex: 'payee',
        sorter: true,
        render: payee => <>{payee ? payee.name : null}</>
      },
      statusCol(),
      {
        title: t('operation'),
        key: 'operation',
        width: 100,
        align: 'center',
        render: (_, record) => {
          return (
            <Space size="small">
              <a onClick={() => copyHandler(record)}>{t('copy')}</a>
              <Dropdown overlay={
                <Menu>
                  {imageEnable ? <Menu.Item onClick={() => imageHandler(record)}>{t('image')}</Menu.Item> : null}
                  <Menu.Item onClick={() => updateHandler(record)}>{t('update')}</Menu.Item>
                  <Menu.Item disabled={record.status !== 2} onClick={() => confirmHandler(record)}>{t('confirm')}</Menu.Item>
                  <Menu.Item disabled={record.status == 2 || record.amount < 0} onClick={() => refundHandler(record)}>{t('refund')}</Menu.Item>
                  <Menu.Item disabled={record.status == 3} onClick={() => deleteHandler(record)}>
                    {
                      record.status == 3 ?
                      <Tooltip title={t('delete.tooltip')}>{t('delete')}</Tooltip>:
                      t('delete')
                    }
                  </Menu.Item>
                </Menu>
              }>
                <a>
                  {t('more')} <DownOutlined />
                </a>
              </Dropdown>
            </Space>
          )
        }
      }
    ]
  );

  function copyHandler(record) {
    showFlowModal(1, 3, {...record});
  }

  const updateHandler = (record) => {
    showFlowModal(1, 2, {...record});
  }

  const messageDeleteConfirm = t('delete.confirm', { name: '' });
  const messageDeleteConfirmBalance = t('delete.confirm.balance');
  const messageOperationSuccess = t('operation.success');
  function deleteHandler(record) {
    Modal.confirm({
      title: record.status === 2 ? messageDeleteConfirm : messageDeleteConfirmBalance,
      onOk: async () => {
        const response = await remove(record);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          dispatch({ type: 'expenses/query', payload: history.location.query });
        }
      }
    });
  }

  function refundHandler(record) {
    showFlowModal(1, 4, {...record});
  }

  const messageConfirmOperation = t('confirm.operation');
  function confirmHandler(record) {
    Modal.confirm({
      title: messageConfirmOperation,
      onOk: async () => {
        const response = await confirm(record);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          dispatch({ type: 'expenses/query', payload: history.location.query });
        }
      }
    });
  }

  return (
    <Table
      {...tableProp}
      columns={columns}
      expandable={{
        expandedRowRender: record => <Descriptions size="small" bordered>
          {record.needConvert ? <Descriptions.Item label={t('convertCurrency')+record.toCurrencyCode}>{record.convertedAmount}</Descriptions.Item> : null}
          {record.notes ? <Descriptions.Item label={t('notes')}>{record.notes}</Descriptions.Item> : null}
        </Descriptions>,
        rowExpandable: record => record.notes || record.needConvert,
      }}
      dataSource={dataAndPagination.data}
      pagination={dataAndPagination.pagination}
      loading={queryLoading}
      onChange={handleTableChange}
    />
  );
}
