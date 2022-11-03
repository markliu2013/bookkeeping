import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Row, Col, Button, Space} from 'antd';
import {useCategoryTreeSelectData, useResponseSelectData} from "@/utils/hooks";
import { filterFormProp } from "@/utils/var";
import {searchHandlerWithCategory} from "@/utils/util";
import {showFlowModal} from '@/utils/flow';
import FormItemDateRange from "@/components/FormItemDateRange";
import FormItemAmountRange from "@/components/FormItemAmountRange";
import FormItemDescriptionSearch from "@/components/FormItemDescriptionSearch";
import FormItemAccounts from "@/components/FormItemAccounts";
import FormItemTags from "@/components/FormItemTags";
import FormItemStatus from "@/components/FormItemStatus";
import t from "@/utils/translate";


export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const loading = useSelector(state => state.loading.effects['transfers/query']);

  useEffect(() => {
    if (!getTransferToAbleResponse) dispatch({ type: 'account/fetchTransferToAble' });
    if (!getTransferFromAbleResponse) dispatch({ type: 'account/fetchTransferFromAble' });
    if (!tagResponse) dispatch({ type: 'tag/fetchTransferable' });
  }, []);

  const { getTransferToAbleResponse } = useSelector(state => state.account);
  const [accountsTransferTo] = useResponseSelectData(getTransferToAbleResponse);

  const { getTransferFromAbleResponse } = useSelector(state => state.account);
  const [accountsTransferFrom] = useResponseSelectData(getTransferFromAbleResponse);

  const { getTransferableResponse : tagResponse } = useSelector(state => state.tag);
  const [tags] = useCategoryTreeSelectData(tagResponse);

  function addHandler() {
    showFlowModal(3, 1, {});
  }

  const [dateRadioValue, setDateRadioValue] = useState();
  function resetHandler() {
    setDateRadioValue();
    form.resetFields();
  }

  return (
    <Form {...filterFormProp} form={form}>
      <Row gutter={20}>
        <FormItemDateRange form={form} dateRadioValue={dateRadioValue} setDateRadioValue={setDateRadioValue} />
        <FormItemAmountRange />
        <FormItemDescriptionSearch />
        <FormItemAccounts data={accountsTransferFrom} label={t('transfer.from.account')} name="fromAccounts" />
        <FormItemAccounts data={accountsTransferTo} label={t('transfer.to.account')} name="toAccounts" />
        <FormItemStatus />
        <FormItemTags data={tags} />
        <Col flex="100px" style={{ marginLeft: 'auto' }}>
          <Space>
            <Button type="primary" onClick={addHandler}>{t('new')}</Button>
            <Button type="primary" loading={loading} onClick={()=>searchHandlerWithCategory(form)}>{t('search')}</Button>
            <Button type="primary" onClick={resetHandler}>{t('form.reset')}</Button>
          </Space>
        </Col>
      </Row>
    </Form>
  );

};
