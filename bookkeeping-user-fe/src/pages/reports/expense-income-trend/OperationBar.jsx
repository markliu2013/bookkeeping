import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Row, Col, Button, Space, Divider} from 'antd';
import {useCategoryTreeSelectData, useResponseData, useResponseSelectData} from "@/utils/hooks";
import { filterFormProp } from "@/utils/var";
import {getNull, radioValueToTimeRange, searchHandler} from "@/utils/util";
import FormItemDateRangeWithBreak from "@/components/FormItemDateRangeWithBreak";
import FormItemAccounts from "@/components/FormItemAccounts";
import FormItemTags from "@/components/FormItemTags";
import FormItemPayees from "@/components/FormItemPayees";
import FormItemCategories from "@/components/FormItemCategories";
import t from '@/utils/translate';


export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const loading = useSelector(state => state.loading.effects['expenseIncomeTrendReports/query']);

  useEffect(() => {
    if (!expenseTagResponse) dispatch({ type: 'tag/fetchExpenseable' });
    if (!expensePayeeResponse) dispatch({ type: 'payee/fetchExpenseable' });
    if (!expenseAccountResponse) dispatch({ type: 'account/fetchExpenseable' });
    if (!expenseCategoryResponse) dispatch({ type: 'incomeCategory/fetchSimple' });

    if (!incomeTagResponse) dispatch({ type: 'tag/fetchIncomeable' });
    if (!incomePayeeResponse) dispatch({ type: 'payee/fetchIncomeable' });
    if (!incomeAccountResponse) dispatch({ type: 'account/fetchIncomeable' });
    if (!incomeCategoryResponse) dispatch({ type: 'expenseCategory/fetchSimple' });
  }, []);

  const { getExpenseableResponse : expenseTagResponse } = useSelector(state => state.tag);
  const [expenseTags] = useCategoryTreeSelectData(expenseTagResponse);

  const { getExpenseableResponse : expensePayeeResponse } = useSelector(state => state.payee);
  const [expensePayees] = useResponseSelectData(expensePayeeResponse);

  const { getExpenseableResponse : expenseAccountResponse } = useSelector(state => state.account);
  const [expenseAccounts] = useResponseSelectData(expenseAccountResponse);

  const { querySimpleResponse: expenseCategoryResponse } = useSelector(state => state.expenseCategory);
  const [expenseCategories] = useCategoryTreeSelectData(expenseCategoryResponse);

  const { getIncomeableResponse : incomeTagResponse } = useSelector(state => state.tag);
  const [incomeTags] = useCategoryTreeSelectData(incomeTagResponse);

  const { getIncomeableResponse : incomePayeeResponse } = useSelector(state => state.payee);
  const [incomePayees] = useResponseSelectData(incomePayeeResponse);

  const { getIncomeableResponse : incomeAccountResponse } = useSelector(state => state.account);
  const [incomeAccounts] = useResponseSelectData(incomeAccountResponse);

  const { querySimpleResponse: incomeCategoryResponse } = useSelector(state => state.incomeCategory);
  const [incomeCategories] = useCategoryTreeSelectData(incomeCategoryResponse);

  const [dateRadioValue, setDateRadioValue] = useState(8);
  function resetHandler() {
    setDateRadioValue(8);
    form.setFieldsValue({...initialValues});
  }

  const [initialValues, setInitialValues] = useState({});
  useEffect(() => {
    setInitialValues({
      'createTimeRange': radioValueToTimeRange(dateRadioValue),
      'breakType': "month"
    });
    searchHandler(form);
  }, []);

  return (
    <Form {...filterFormProp} form={form}>
      <FormItemDateRangeWithBreak form={form} dateRadioValue={dateRadioValue} setDateRadioValue={setDateRadioValue} />
      <Divider orientation="left" plain style={{marginTop:0}}>{t('report.expense.condition')}</Divider>
      <Row gutter={8}>
        <FormItemAccounts data={expenseAccounts} name="expenseAccounts" />
        <FormItemPayees data={expensePayees} name="expensePayees" />
        <FormItemCategories data={expenseCategories} name="expenseCategories" />
        <FormItemTags data={expenseTags} name="expenseTags" />
      </Row>
      <Divider orientation="left" plain style={{marginTop:0}}>{t('report.income.condition')}</Divider>
      <Row gutter={8}>
        <FormItemAccounts data={incomeAccounts} name="incomeAccounts" />
        <FormItemPayees data={incomePayees} name="incomePayees" />
        <FormItemCategories data={incomeCategories} name="incomeCategories" />
        <FormItemTags data={incomeTags} name="incomeTags" />
      </Row>
      <Row>
        <Col flex="auto" style={{ textAlign:'right' }}>
          <Space>
            <Button type="primary" loading={loading} onClick={()=>searchHandler(form)}>{t('search')}</Button>
            <Button type="primary" onClick={resetHandler}>{t('form.reset')}</Button>
          </Space>
        </Col>
      </Row>
    </Form>
  );

};
