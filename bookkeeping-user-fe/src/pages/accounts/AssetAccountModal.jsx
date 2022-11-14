import {useDispatch, useSelector} from "umi";
import { useState, useEffect } from 'react';
import {Form, Input, Switch, Col, Row, Select} from 'antd';
import FormModal from "@/components/FormModal";
import {nameRules, notesRules, balanceRequiredRules, requiredRules} from '@/utils/rules';
import { formProp }  from '@/utils/var';
import {getNull, tableChangeQueryFormat} from '@/utils/util';
import { create } from '@/services/asset-account';
import { update } from '@/services/account';
import {useCurrencyResponseSelectData} from "@/utils/hooks";
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const {
    assetAccountPagination : pagination,
    assetAccountSorter : sorter
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
        expenseable: false,
        incomeable: false,
        transferToAble: true,
        transferFromAble: true,
        currencyCode: defaultGroup.defaultCurrencyCode
      });
    } else {
      // 数字类型的校验存在问题, antd bug
      currentItem.balance = currentItem.balance.toString();
      setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
    }
  }, [visible, type, currentItem]);

  function successHandler(response) {
    dispatch({ type: 'accounts/queryAssetAccount', payload: tableChangeQueryFormat(pagination, sorter) });
    dispatch({ type: 'account/refresh', payload: { ...response.data } });
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + t('asset.account')}
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
