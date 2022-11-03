import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Row, Col, Button, Select, Space, Checkbox, Input} from 'antd';
import {useCategoryTreeSelectData, useResponseData, useResponseSelectData} from "@/utils/hooks";
import { filterFormProp } from "@/utils/var";
import { searchHandler } from "@/utils/util";
import FormItemDateRange from "@/components/FormItemDateRange";
import FormItemAccounts from "@/components/FormItemAccounts";
import FormItemCategoryReport from "@/components/FormItemCategoryReport";
import FormItemDescriptionSearch from "@/components/FormItemDescriptionSearch";
import FormItemPayees from "@/components/FormItemPayees";
import FormItemTags from "@/components/FormItemTags";
import t from '@/utils/translate';
import Pie from "@/components/charts/Pie2";


export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const loading = useSelector(state => state.loading.effects['incomeCategoryReports/query']);

  useEffect(() => {
    if (!tagResponse) dispatch({ type: 'tag/fetchIncomeable' });
    if (!payeeResponse) dispatch({ type: 'payee/fetchIncomeable' });
    if (!accountResponse) dispatch({ type: 'account/fetchIncomeable' });
    if (!querySimpleResponse) dispatch({ type: 'incomeCategory/fetchSimple' });
  }, []);

  const { getIncomeableResponse : tagResponse } = useSelector(state => state.tag);
  const [tags] = useCategoryTreeSelectData(tagResponse);

  const { getIncomeableResponse : payeeResponse } = useSelector(state => state.payee);
  const [payees] = useResponseSelectData(payeeResponse);

  const { getIncomeableResponse : accountResponse } = useSelector(state => state.account);
  const [accounts] = useResponseSelectData(accountResponse);

  const { querySimpleResponse } = useSelector(state => state.incomeCategory);
  const [categories] = useCategoryTreeSelectData(querySimpleResponse);

  const [dateRadioValue, setDateRadioValue] = useState(8);
  function resetHandler() {
    setDateRadioValue();
    form.resetFields();
  }

  return (
    <Form {...filterFormProp} form={form}>
      <Row gutter={8}>
        <FormItemDateRange form={form} dateRadioValue={dateRadioValue} setDateRadioValue={setDateRadioValue} />
        <FormItemDescriptionSearch />
        <FormItemAccounts data={accounts} />
        <FormItemPayees data={payees} />
        <FormItemCategoryReport data={categories} />
        <FormItemTags data={tags} />
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
