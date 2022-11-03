import {useDispatch, useSelector} from "umi";
import { useState, useEffect } from 'react';
import {Form, Input, Switch, Col, Row, Select} from 'antd';
import {nameRules, notesRules, balanceRequiredRules, limitRequiredRules, requiredRules} from '@/utils/rules';
import { formProp }  from '@/utils/var';
import { getNull, tableChangeQueryFormat }  from '@/utils/util';
import { create } from '@/services/credit-account';
import { update } from '@/services/account';
import FormModal from "@/components/FormModal";
import t from "@/utils/translate";
import {useCurrencyResponseSelectData} from "@/utils/hooks";


export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const {
    creditAccountPagination : pagination,
    creditAccountSorter : sorter
  } = useSelector(state => state.accounts);

  const { defaultGroup } = useSelector(state => state.session);
  const { getAllResponse : currencyResponse } = useSelector(state => state.currency);
  const [currencyList] = useCurrencyResponseSelectData(currencyResponse);
  useEffect(() => {
    if (visible) {
      if (!currencyResponse) dispatch({ type: 'currency/fetchAll' });
      if (!defaultGroup) dispatch({ type: 'session/fetchSession' });
    }
  }, [visible]);

  const [initialValues, setInitialValues] = useState({});
  useEffect(() => {
    if (!visible) return;
    if (type === 1) {
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        include: true,
        expenseable: true,
        incomeable: false,
        transferToAble: true,
        transferFromAble: false,
        currencyCode: defaultGroup.defaultCurrencyCode
      });
    } else {
      // 数字类型的校验存在问题, antd bug
      currentItem.balance = currentItem.balance.toString();
      currentItem.limit = currentItem.limit.toString();
      setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
    }
  }, [visible, type, currentItem]);

  function successHandler(response) {
    dispatch({ type: 'accounts/queryCreditAccount', payload: tableChangeQueryFormat(pagination, sorter) });
    dispatch({ type: 'account/refresh', payload: { ...response.data } });
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + t('credit.account')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={(response) => successHandler(response)}
    >
      <Form {...formProp} form={form}>
        <Form.Item label={t('currency')} name="currencyCode" rules={requiredRules()} labelCol={{ style: { width: 68 } }}>
          <Select options={currencyList} showArrow showSearch filterOption optionFilterProp={"label"} disabled={type === 2} />
        </Form.Item>
        <Form.Item label={t('name')} name="name" rules={nameRules()} labelCol={{ style: { width: 68 } }}>
          <Input />
        </Form.Item>
        <Form.Item label={t('account.current.balance')} name="balance" rules={balanceRequiredRules()} labelCol={{ style: { width: 68 } }}>
          <Input disabled={type === 2} />
        </Form.Item>
        <Row gutter={8}>
          <Col span={12}>
            <Form.Item label={t('credit.limit')} name="limit" rules={limitRequiredRules()} labelCol={{ style: { width: 68 } }}>
              <Input />
            </Form.Item>
          </Col>
          <Col span={12}>
            <Form.Item label={t('account.billDay')} name="billDay">
              <Select allowClear={true} showSearch>
                {Array(31).fill().map((_, i) => <Select.Option key={i} value={i+1}>{i+1}</Select.Option>)}
              </Select>
            </Form.Item>
          </Col>
        </Row>
        <Form.Item label={t('account.card.no')} name="no" labelCol={{ style: { width: 68 } }}>
          <Input />
        </Form.Item>
        <Row gutter={8}>
          <Col span={6}>
            <Form.Item label={t('expenseable')} valuePropName="checked" name="expenseable">
              <Switch />
            </Form.Item>
          </Col>
          <Col span={6}>
            <Form.Item label={t('incomeable')} valuePropName="checked" name="incomeable">
              <Switch />
            </Form.Item>
          </Col>
          <Col span={6}>
            <Form.Item label={t('transferToAble')} valuePropName="checked" name="transferToAble">
              <Switch />
            </Form.Item>
          </Col>
          <Col span={6}>
            <Form.Item label={t('transferFromAble')} valuePropName="checked" name="transferFromAble">
              <Switch />
            </Form.Item>
          </Col>
        </Row>
        <Form.Item label={t('account.include')} valuePropName="checked" name="include">
          <Switch />
        </Form.Item>
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
