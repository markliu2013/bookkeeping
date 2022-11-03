import { useEffect, useState } from 'react';
import {useDispatch, useSelector} from 'umi';
import { Form, Input, Switch } from 'antd';
import moment from 'moment';
import { create, update } from '@/services/transfer';
import {useCategoryTreeSelectData, useResponseData} from "@/utils/hooks";
import FormItemDescription from '@/components/FormItemDescription';
import FormItemCreateTime from '@/components/FormItemCreateTime';
import FormItemAccount from '@/components/FormItemAccount';
import FormModal from "@/components/FormModal";
import FormItemTag from "@/components/FormItemTag";
import {amountRequiredRulesPositive, requiredRules} from "@/utils/rules";
import {getNull, refreshFlow} from "@/utils/util";
import t from '@/utils/translate';
import styles from './index.less';


export default (props) => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const { defaultBook } = useSelector(state => state.session);

  const { getTransferableResponse : tagResponse } = useSelector(state => state.tag);
  const [tags] = useCategoryTreeSelectData(tagResponse);

  const { getTransferToAbleResponse } = useSelector(state => state.account);
  const [accountsTransferTo] = useResponseData(getTransferToAbleResponse);

  const { getTransferFromAbleResponse } = useSelector(state => state.account);
  const [accountsTransferFrom] = useResponseData(getTransferFromAbleResponse);

  useEffect(() => {
    if (visible) {
      if (!defaultBook) dispatch({ type: 'session/fetchSession' });
      if (!tagResponse) dispatch({ type: 'tag/fetchTransferable' });
      if (!getTransferToAbleResponse) dispatch({ type: 'account/fetchTransferToAble' });
      if (!getTransferFromAbleResponse) dispatch({ type: 'account/fetchTransferFromAble' });
    }
  }, [visible]);

  const [initialValues, setInitialValues] = useState({})
  useEffect(() => {
    if (!visible) return;
    if (type === 1) {
      let fromId = null;
      if (defaultBook && defaultBook.defaultTransferFromAccount) {
        fromId = defaultBook.defaultTransferFromAccount.id;
      }
      let toId = null;
      if (defaultBook && defaultBook.defaultTransferToAccount) {
        toId = defaultBook.defaultTransferToAccount.id;
      }
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        'createTime': moment(),
        'fromId': fromId,
        'toId': toId,
        'tags': [],
        'confirmed': true,
      });
      if (defaultBook && defaultBook.defaultTransferFromAccount) {
        setFromCurrencyCode(defaultBook.defaultTransferFromAccount.currencyCode);
      } else {
        setFromCurrencyCode('');
      }
      if (defaultBook && defaultBook.defaultTransferToAccount) {
        setToCurrencyCode(defaultBook.defaultTransferToAccount.currencyCode);
      } else {
        setToCurrencyCode('');
      }
    } else {
      let currentItemCopy = JSON.parse(JSON.stringify(currentItem));
      if (type === 3) { //不复制备注
        currentItemCopy.notes = "";
      }
      // 数字类型的校验存在问题, antd bug
      currentItemCopy.amount = currentItemCopy.amount.toString();
      currentItemCopy.createTime = type === 3 ? moment() : moment(currentItemCopy.createTime);
      currentItemCopy.tags = currentItemCopy.tags ? currentItemCopy.tags.map(item => item.tagId) : null;
      currentItemCopy.confirmed = type === 3 ? true : currentItemCopy.status === 1;
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        ...currentItemCopy
      });
      setFromCurrencyCode(currentItemCopy.currencyCode);
      setToCurrencyCode(currentItemCopy.toCurrencyCode);
    }
  }, [visible, type, currentItem]);

  function successHandler(response) {
    refreshFlow(response.data);
  }

  const [fromCurrencyCode, setFromCurrencyCode] = useState();
  const [toCurrencyCode, setToCurrencyCode] = useState();
  const fromAccountChangeHandler = (value) => {
    for (let i = 0; i < accountsTransferFrom.length; i++) {
      if (accountsTransferFrom[i].id === value) {
        setFromCurrencyCode(accountsTransferFrom[i].currencyCode);
      }
    }
  }
  const toAccountChangeHandler = (value) => {
    for (let i = 0; i < accountsTransferTo.length; i++) {
      if (accountsTransferTo[i].id === value) {
        setToCurrencyCode(accountsTransferTo[i].currencyCode);
      }
    }
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : type === 3 ? t('copy') : t('update')) + t('transfer')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={(response) => successHandler(response)}
    >
      <Form form={form} className={styles['form']}>
        <FormItemDescription />
        <FormItemCreateTime />
        <FormItemAccount data={accountsTransferFrom} label={t('transfer.from.account')} name="fromId" onSelectChange={fromAccountChangeHandler} />
        <FormItemAccount data={accountsTransferTo} label={t('transfer.to.account')} name="toId" onSelectChange={toAccountChangeHandler} />
        <Form.Item label={t('amount')} name="amount" rules={amountRequiredRulesPositive()}>
          <Input />
        </Form.Item>
        {
          fromCurrencyCode && toCurrencyCode && fromCurrencyCode !== toCurrencyCode ?
            <Form.Item label={t('convertCurrency')+toCurrencyCode} name="convertedAmount" rules={requiredRules()}>
              <Input />
            </Form.Item> : null
        }
        <FormItemTag data={tags} type={3} />
        {(type !== 2) &&
        <Form.Item label={t('flow.isConfirmed')} valuePropName="checked" name="confirmed">
          <Switch />
        </Form.Item>
        }
        <Form.Item label={t('notes')} name="notes">
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
