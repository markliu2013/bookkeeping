import { useState, useEffect } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Row, Col, Button, Space} from 'antd';
import { useResponseSelectData, useCategoryTreeSelectData } from "@/utils/hooks";
import { filterFormProp } from "@/utils/var";
import { searchHandlerWithCategory } from "@/utils/util";
import {showFlowModal} from '@/utils/flow';
import FormItemDateRange from "@/components/FormItemDateRange";
import FormItemAmountRange from "@/components/FormItemAmountRange";
import FormItemAccounts from "@/components/FormItemAccounts";
import FormItemPayees from "@/components/FormItemPayees";
import FormItemTags from "@/components/FormItemTags";
import FormItemCategories from "@/components/FormItemCategories";
import FormItemDescriptionSearch from "@/components/FormItemDescriptionSearch";
import FormItemStatus from "@/components/FormItemStatus";
import t from '@/utils/translate';


export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();
  const loading = useSelector(state => state.loading.effects['incomes/query']);

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

  function addHandler() {
    showFlowModal(2, 1, {});
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
        <FormItemCategories data={categories} />
        <FormItemPayees data={payees} />
        <FormItemAccounts data={accounts} />
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
