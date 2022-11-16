import { useEffect, useState } from 'react';
import {useDispatch, useSelector} from 'umi';
import {Form, Input, Switch} from 'antd';
import moment from 'moment';
import FormModal from "@/components/FormModal";
import FormListCategory from '@/components/FormListCategory';
import FormItemAccount from "@/components/FormItemAccount";
import FormItemDescription from '@/components/FormItemDescription';
import FormItemCreateTime from '@/components/FormItemCreateTime';
import FormItemPayee from '@/components/FormItemPayee';
import FormItemTag from '@/components/FormItemTag';
import { create, update, refund } from '@/services/income';
import {
  useCategoryTreeSelectData,
  useResponseData,
  useResponseSelectData
} from "@/utils/hooks";
import {getNull, refreshFlow} from "@/utils/util";
import t from '@/utils/translate';
import styles from './index.less';

export default (props) => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { defaultBook } = useSelector(state => state.session);
  const { visible, type, currentItem } = useSelector(state => state.modal);

  const { getIncomeableResponse : tagResponse } = useSelector(state => state.tag);
  const [tags] = useCategoryTreeSelectData(tagResponse);

  const { getIncomeableResponse : payeeResponse } = useSelector(state => state.payee);
  const [payees, setPayees] = useResponseSelectData(payeeResponse);

  const { getIncomeableResponse : accountResponse } = useSelector(state => state.account);
  const [accounts] = useResponseData(accountResponse);

  const { querySimpleResponse } = useSelector(state => state.incomeCategory);
  const [categories] = useCategoryTreeSelectData(querySimpleResponse);

  useEffect(() => {
    if (visible) {
      if (!defaultBook) dispatch({ type: 'session/fetchSession' });
      if (!tagResponse) dispatch({ type: 'tag/fetchIncomeable' });
      if (!payeeResponse) dispatch({ type: 'payee/fetchIncomeable' });
      if (!accountResponse) dispatch({ type: 'account/fetchIncomeable' });
      if (!querySimpleResponse) dispatch({ type: 'incomeCategory/fetchSimple' });
    }
  }, [visible]);

  const [initialValues, setInitialValues] = useState({})
  useEffect(() => {
    if (!visible) return;
    if (type === 1) {
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        'createTime': moment(),
        'accountId': defaultBook && defaultBook.defaultIncomeAccount && defaultBook.defaultIncomeAccount.id,
        'categories': defaultBook && defaultBook.defaultIncomeCategory ? [{ categoryId: defaultBook.defaultIncomeCategory.id }] : [{ }],
        'tags': [],
        'confirmed': true,
      });
      if (defaultBook && defaultBook.defaultIncomeAccount) {
        setAccountCurrencyCode(defaultBook.defaultIncomeAccount.currencyCode);
      } else {
        setAccountCurrencyCode('');
      }
    } else {
      let currentItemCopy = JSON.parse(JSON.stringify(currentItem));
      if (type === 4) {
        if (currentItemCopy.categories) currentItemCopy.categories.forEach(value => {
          value.amount = value.amount*(-1);
          value.convertedAmount = value.convertedAmount*(-1)
        });
      }
      if (type === 3 || type === 4) { //不复制备注
        currentItemCopy.notes = "";
      }
      // 数字类型的校验存在问题, antd bug
      if (currentItemCopy.categories) currentItemCopy.categories.forEach(value => {value.amount = value.amount.toString();value.convertedAmount = value.convertedAmount.toString()});
      currentItemCopy.createTime = type === 2 ? moment(currentItemCopy.createTime) : moment();
      currentItemCopy.accountId = currentItemCopy.account ? currentItemCopy.account.id : null;
      currentItemCopy.payeeId = currentItemCopy.payee ? currentItemCopy.payee.id : null;
      currentItemCopy.tags = currentItemCopy.tags ? currentItemCopy.tags.map(item => item.tagId) : null;
      currentItemCopy.confirmed = type === 3 ? true : currentItemCopy.status === 1;
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        ...currentItemCopy,
        'categories': currentItemCopy.categories ? currentItemCopy.categories : [{}],
      });
      setAccountCurrencyCode(currentItemCopy.currencyCode);
    }
  }, [visible, type, currentItem]);

  function successHandler(response) {
    refreshFlow(response.data);
  }

  const [accountCurrencyCode, setAccountCurrencyCode] = useState();
  const accountChangeHandler = (value) => {
    for (let i = 0; i < accounts.length; i++) {
      if (accounts[i].id === value) {
        setAccountCurrencyCode(accounts[i].currencyCode);
      }
    }
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : type === 2 ? t('update') : type === 3 ? t('copy') : t('refund')) + t('income')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      refund={refund}
      onSuccess={(response) => successHandler(response)}
    >
      <Form form={form} className={styles['form']}>
        <FormItemDescription />
        <FormItemCreateTime />
        <FormItemAccount data={accounts} required={true} onSelectChange={accountChangeHandler} />
        <FormListCategory categories={categories} isConvert={defaultBook && accountCurrencyCode && defaultBook.defaultCurrencyCode !== accountCurrencyCode} currency={t('convertCurrency')+defaultBook.defaultCurrencyCode} />
        <FormItemPayee form={form} payees={payees} setPayees={setPayees} type={2} />
        <FormItemTag data={tags} type={2} />
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
