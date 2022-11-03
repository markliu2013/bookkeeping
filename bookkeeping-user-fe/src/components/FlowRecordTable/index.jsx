import {Button, message, Modal, Space, Table, Descriptions, Dropdown, Menu} from 'antd';
import {DownOutlined} from "@ant-design/icons";
import {tableProp} from "@/utils/var";
import {amountCol, createTimeCol, flowTypeCol, statusCol} from '@/utils/columns';
import {useDescriptionEnable, useImageEnable, useTimeFormat} from "@/utils/hooks";
import {refreshFlow} from "@/utils/util";
import {imageHandler, showFlowModal} from '@/utils/flow';
import FlowTagDisplay from '@/components/FlowTagDisplay';
import { remove, confirm } from '@/services/flow';
import t from "@/utils/translate";

export default (props) => {

  const {
    queryLoading,
    data,
    pagination,
    tableChangeHandler,
    bordered,
    noBook,
  } = props;

  const imageEnable = useImageEnable();
  const descriptionEnable = useDescriptionEnable();
  const timeFormat = useTimeFormat();

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
          refreshFlow(response.data);
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
          refreshFlow(response.data);
        }
      }
    });
  }

  function refundHandler(record) {
    if (record.type === 1) {
      showFlowModal(1, 4, { ...record.expense });
    } else if (record.type === 2) {
      showFlowModal(2, 4, { ...record.income });
    }
  }

  function copyHandler(record) {
    if (record.type === 1) {
      showFlowModal(1, 3, { ...record.expense });
    } else if (record.type === 2) {
      showFlowModal(2, 3, { ...record.income });
    } else if (record.type === 3) {
      showFlowModal(3, 3, { ...record.transfer });
    }
  }

  function updateHandler(record) {
    if (record.type === 1) {
      showFlowModal(1, 2, { ...record.expense });
    } else if (record.type === 2) {
      showFlowModal(2, 2, { ...record.income });
    } else if (record.type === 3) {
      showFlowModal(3, 2, { ...record.transfer });
    }
  }

  let columns = [];
  if (!noBook) {
    columns.push({
      title: t('flow.book'),
      dataIndex: 'bookName',
    });
  }
  if (descriptionEnable) {
    columns.push({
      title: t('description'),
      dataIndex: 'description',
    });
  }
  columns = columns.concat(
    [
      flowTypeCol(),
      amountCol(),
      createTimeCol(timeFormat),
      {
        title: t('account'),
        dataIndex: 'accountName',
      },
      {
        title: t('category'),
        dataIndex: 'categoryName',
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
              <Button type="link" size="small" disabled={record.type === 4} onClick={() => copyHandler(record)}>{t('copy')}</Button>
              <Dropdown overlay={
                <Menu>
                  {imageEnable ? <Menu.Item onClick={() => imageHandler(record)}>{t('image')}</Menu.Item> : null}
                  <Menu.Item disabled={record.type === 4} onClick={() => updateHandler(record)}>{t('update')}</Menu.Item>
                  <Menu.Item disabled={record.status !== 2} onClick={() => confirmHandler(record)}>{t('confirm')}</Menu.Item>
                  <Menu.Item disabled={!((record.type === 1 || record.type === 2) && (record.status !== 2 && record.amount > 0))} onClick={() => refundHandler(record)}>{t('refund')}</Menu.Item>
                  <Menu.Item disabled={record.status == 3} onClick={() => deleteHandler(record)}>{t('delete')}</Menu.Item>
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

  function rowExpandableRecord(record) {
    if (record.notes) {
      return true;
    }
    return record.needConvert;
  }

  function descriptionsItemRecord(record) {
    let notesItem = null;
    if (record.notes) {
      notesItem = <Descriptions.Item label={t('notes')}>{record.notes}</Descriptions.Item>;
    }
    let currencyItem = null;
    if (record.needConvert) {
      currencyItem = <Descriptions.Item label={t('convertCurrency')+record.toCurrencyCode}>{record.convertedAmount}</Descriptions.Item>
    }
    return <>{notesItem}{currencyItem}</>;
  }

  return (
    <Table
      {...tableProp}
      bordered={bordered}
      columns={columns}
      expandable={{
        expandedRowRender: record => <Descriptions size="small" bordered>
          {descriptionsItemRecord(record)}
        </Descriptions>,
        rowExpandable: record => rowExpandableRecord(record),
      }}
      dataSource={data}
      pagination={pagination}
      loading={queryLoading}
      onChange={tableChangeHandler}
    />
  );
};
