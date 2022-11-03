import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'umi';
import { Form, Row, Col, Button, Select, Space } from 'antd';
import { filterFormProp } from "@/utils/var";
import {searchHandler} from "@/utils/util";
import {useResponseSelectData, useCategoryTreeSelectData} from "@/utils/hooks";
import FormItemDateRange from "@/components/FormItemDateRange";
import FormItemAmountRange from "@/components/FormItemAmountRange";
import FormItemAccounts from "@/components/FormItemAccounts";
import FormItemPayees from "@/components/FormItemPayees";
import FormItemTags from "@/components/FormItemTags";
import FormItemStatus from "@/components/FormItemStatus";
import FormItemDescriptionSearch from "@/components/FormItemDescriptionSearch";
import t from "@/utils/translate";


export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const loading = useSelector(state => state.loading.effects['audit/query']);

  useEffect(() => {
    if (!accountResponse) dispatch({ type: 'account/fetchEnable' });
  }, []);

  const { getEnableResponse : accountResponse } = useSelector(state => state.account);
  const [accounts] = useResponseSelectData(accountResponse);

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
        <Col flex="200px">
          <Form.Item label={t('flow.type')} name="type">
            <Select allowClear={true}>
              <Select.Option value={1}>{t('expense')}</Select.Option>
              <Select.Option value={2}>{t('income')}</Select.Option>
              <Select.Option value={3}>{t('transfer')}</Select.Option>
              <Select.Option value={4}>{t('adjust.balance')}</Select.Option>
            </Select>
          </Form.Item>
        </Col>
        <FormItemAccounts data={accounts} />
        <FormItemStatus />
        <Col flex="100px" style={{ marginLeft: 'auto' }}>
          <Space>
            <Button type="primary" loading={loading} onClick={()=>searchHandler(form)}>{t('search')}</Button>
            <Button type="primary" onClick={resetHandler}>{t('form.reset')}</Button>
          </Space>
        </Col>
      </Row>
    </Form>
  );

};
