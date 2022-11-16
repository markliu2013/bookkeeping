import {useEffect, useState} from 'react';
import {useDispatch, useSelector} from 'umi';
import {Form, Input, Switch} from 'antd';
import moment from 'moment';
import {
  useCategoryTreeSelectData,
  useResponseData,
  useResponseSelectData
} from "@/utils/hooks";
import {getNull, refreshFlow} from "@/utils/util";
import FormModal from "@/components/FormModal";
import FormItemAccount from '@/components/FormItemAccount';
import FormListCategory from '@/components/FormListCategory';
import FormItemTag from '@/components/FormItemTag';
import FormItemPayee from '@/components/FormItemPayee';
import FormItemDescription from '@/components/FormItemDescription';
import FormItemCreateTime from '@/components/FormItemCreateTime';
import { create, update, refund } from '@/services/expense';
import t from '@/utils/translate';
import styles from './index.less';

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { defaultBook } = useSelector(state => state.session);
  const { visible, type, currentItem } = useSelector(state => state.modal);

  const { getExpenseableResponse : tagResponse } = useSelector(state => state.tag);
  const [tags] = useCategoryTreeSelectData(tagResponse);

  const { getExpenseableResponse : payeeResponse } = useSelector(state => state.payee);
  const [payees, setPayees] = useResponseSelectData(payeeResponse);

  const { getExpenseableResponse : accountResponse } = useSelector(state => state.account);
  const [accounts] = useResponseData(accountResponse);

  const { querySimpleResponse } = useSelector(state => state.expenseCategory);
  const [categories] = useCategoryTreeSelectData(querySimpleResponse);

  // TODO 很多地方有这个只加载一次的数据，待优化
  useEffect(() => {
    if (visible) {
      if (!defaultBook) dispatch({ type: 'session/fetchSession' });
      if (!tagResponse) dispatch({ type: 'tag/fetchExpenseable' });
      if (!payeeResponse) dispatch({ type: 'payee/fetchExpenseable' });
      if (!accountResponse) dispatch({ type: 'account/fetchExpenseable' });
      if (!querySimpleResponse) dispatch({ type: 'expenseCategory/fetchSimple' });
    }
  }, [visible]);

  const [initialValues, setInitialValues] = useState({}); // 默认值必须为空，currentItem报错date.clone is not a function，调试了半天。
  useEffect(() => {
    if (!visible) return;
    if (type === 1) {
      setInitialValues({
        ...getNull(form.getFieldsValue()), //清空上次输入的
        'createTime': moment(),
        'accountId': defaultBook && defaultBook.defaultExpenseAccount && defaultBook.defaultExpenseAccount.id,
        'categories': defaultBook && defaultBook.defaultExpenseCategory ? [{ categoryId: defaultBook.defaultExpenseCategory.id }] : [{ }],
        'tags': [],
        'confirmed': true,
      });
      if (defaultBook && defaultBook.defaultExpenseAccount) {
        setAccountCurrencyCode(defaultBook.defaultExpenseAccount.currencyCode);
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
      currentItemCopy.confirmed = type === 3 || type === 4 ? true : currentItemCopy.status === 1;
      /*
      处理修改时，账户已禁用的情况，未完。
      if (type === 3) {
        if (!currentItemCopy.account.enable) {
          currentItemCopy.accountId = null;
        }
      } else if (!currentItemCopy.account.enable) {
        if (!accounts.some(e => e.id === currentItemCopy.account.id)) {
          setAccounts([{ id: currentItemCopy.account.id, name: currentItemCopy.account.name }, ...accounts]);
        }
      }
      */
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
      title={(type === 1 ? t('new') : type === 2 ? t('update') : type === 3 ? t('copy') : t('refund')) + t('expense')}
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
        <FormItemPayee form={form} payees={payees} setPayees={setPayees} type={1} />
        <FormItemTag data={tags} type={1} />
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
