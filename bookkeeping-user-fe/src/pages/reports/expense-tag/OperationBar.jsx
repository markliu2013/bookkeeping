import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Row, Col, Button, Space} from 'antd';
import {useCategoryTreeSelectData, useResponseData, useResponseSelectData} from "@/utils/hooks";
import { filterFormProp } from "@/utils/var";
import { searchHandlerWithCategory } from "@/utils/util";
import FormItemDateRange from "@/components/FormItemDateRange";
import FormItemAccounts from "@/components/FormItemAccounts";
import FormItemCategories from "@/components/FormItemCategories";
import FormItemDescriptionSearch from "@/components/FormItemDescriptionSearch";
import FormItemPayees from "@/components/FormItemPayees";
import FormItemTagReport from "@/components/FormItemTagReport";
import t from '@/utils/translate';
import Pie from "@/components/charts/Pie2";


export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const loading = useSelector(state => state.loading.effects['expenseTagReports/query']);

  useEffect(() => {
    if (!tagResponse) dispatch({ type: 'tag/fetchExpenseable' });
    if (!payeeResponse) dispatch({ type: 'payee/fetchExpenseable' });
    if (!accountResponse) dispatch({ type: 'account/fetchExpenseable' });
    if (!querySimpleResponse) dispatch({ type: 'expenseCategory/fetchSimple' });
  }, []);

  const { getExpenseableResponse : tagResponse } = useSelector(state => state.tag);
  const [tags] = useCategoryTreeSelectData(tagResponse);

  const { getExpenseableResponse : payeeResponse } = useSelector(state => state.payee);
  const [payees] = useResponseSelectData(payeeResponse);

  const { getExpenseableResponse : accountResponse } = useSelector(state => state.account);
  const [accounts] = useResponseSelectData(accountResponse);

  const { querySimpleResponse } = useSelector(state => state.expenseCategory);
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
        <FormItemCategories data={categories} />
        <FormItemTagReport data={tags} />
        <Col flex="100px" style={{ marginLeft: 'auto' }}>
          <Space>
            <Button type="primary" loading={loading} onClick={()=>searchHandlerWithCategory(form)}>{t('search')}</Button>
            <Button type="primary" onClick={resetHandler}>{t('form.reset')}</Button>
          </Space>
        </Col>
      </Row>
    </Form>
  );

};
