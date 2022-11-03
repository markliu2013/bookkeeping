import { history, useDispatch, useSelector } from 'umi';
import {Table, Space, message, Modal, Tag, Descriptions, Dropdown, Menu } from 'antd';
import {DownOutlined} from "@ant-design/icons";
import { remove, confirm } from '@/services/flow';
import {useDescriptionEnable, useImageEnable, useResultPaginationAndData, useTimeFormat} from '@/utils/hooks';
import { handleTableChange } from "@/utils/util";
import {imageHandler, showFlowModal} from '@/utils/flow';
import { tableProp } from '@/utils/var';
import {createTimeCol, amountCol, statusCol} from '@/utils/columns';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();

  const { queryResponse } = useSelector(state => state.transfers);
  const queryLoading = useSelector(state => state.loading.effects['transfers/query']);
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
        title: t('account'),
        dataIndex: 'accountName',
      },
      {
        title: t('flow.tag'),
        dataIndex: 'tags',
        render: tags => <>{tags.map(i => <Tag color="blue" key={i.tagId}>{i.tagName}</Tag>)}</>
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
                  <Menu.Item onClick={() => deleteHandler(record)}>{t('delete')}</Menu.Item>
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
    showFlowModal(3, 3, {...record});
  }

  const updateHandler = (record) => {
    showFlowModal(3, 2, {...record});
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
          dispatch({ type: 'transfers/query', payload: history.location.query });
        }
      }
    });
  }

  const messageConfirmOperation = t('confirm.operation');
  function confirmHandler(record) {
    Modal.confirm({
      title: messageConfirmOperation,
      onOk: async () => {
        const response = await confirm(record);
        if (response && response.success) {
          message.success(messageOperationSuccess);
          dispatch({ type: 'transfers/query', payload: history.location.query });
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
