import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Select, TreeSelect, Switch} from 'antd';
import {config} from '@/services/book';
import {useCategoryTreeSelectData, useResponseSelectData} from "@/utils/hooks";
import {getNull} from "@/utils/util";
import FormModal from "@/components/FormModal";
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, currentItem } = useSelector(state => state.modal);

  const { getExpenseableResponse } = useSelector(state => state.account);
  const [expenseAccounts] = useResponseSelectData(getExpenseableResponse);

  const { getIncomeableResponse } = useSelector(state => state.account);
  const [incomeAccounts] = useResponseSelectData(getIncomeableResponse);

  const { getTransferFromAbleResponse } = useSelector(state => state.account);
  const [transferFromAccounts] = useResponseSelectData(getTransferFromAbleResponse);

  const { getTransferToAbleResponse } = useSelector(state => state.account);
  const [transferToAccounts] = useResponseSelectData(getTransferToAbleResponse);

  const { querySimpleResponse : expenseCategoryResponse } = useSelector(state => state.expenseCategory);
  const [expenseCategories] = useCategoryTreeSelectData(expenseCategoryResponse);

  const { querySimpleResponse : incomeCategoryResponse } = useSelector(state => state.incomeCategory);
  const [incomeCategories] = useCategoryTreeSelectData(incomeCategoryResponse);
  useEffect(() => {
    if (visible) {
      if (!getExpenseableResponse) dispatch({ type: 'account/fetchExpenseable' });
      if (!getIncomeableResponse) dispatch({ type: 'account/fetchIncomeable' });
      if (!getTransferFromAbleResponse) dispatch({ type: 'account/fetchTransferFromAble' });
      if (!getTransferToAbleResponse) dispatch({ type: 'account/fetchTransferToAble' });
      if (!expenseCategoryResponse) dispatch({ type: 'expenseCategory/fetchSimple' });
      if (!incomeCategoryResponse) dispatch({ type: 'incomeCategory/fetchSimple' });
    }
  }, [visible]);

  const [initialValues, setInitialValues] = useState({})
  useEffect(() => {
    if (visible) {
      let currentItemCopy = {...currentItem};
      currentItemCopy.defaultExpenseAccountId = currentItemCopy.defaultExpenseAccount ? currentItemCopy.defaultExpenseAccount.id : null;
      currentItemCopy.defaultIncomeAccountId = currentItemCopy.defaultIncomeAccount ? currentItemCopy.defaultIncomeAccount.id : null;
      currentItemCopy.defaultTransferFromAccountId = currentItemCopy.defaultTransferFromAccount ? currentItemCopy.defaultTransferFromAccount.id : null;
      currentItemCopy.defaultTransferToAccountId = currentItemCopy.defaultTransferToAccount ? currentItemCopy.defaultTransferToAccount.id : null;
      currentItemCopy.defaultExpenseCategoryId = currentItemCopy.defaultExpenseCategory ? currentItemCopy.defaultExpenseCategory.id : null;
      currentItemCopy.defaultIncomeCategoryId = currentItemCopy.defaultIncomeCategory ? currentItemCopy.defaultIncomeCategory.id : null;
      setInitialValues({...getNull(form.getFieldsValue()), ...currentItemCopy});
    }
  }, [visible]);

  function successHandler(response) {
    dispatch({ type: 'books/query' });
    dispatch({
      type: 'session/updateState',
      payload: { defaultBook: response.data }
    });
  }

  return (
    <FormModal
      title={t('config') + t('book')}
      form={form}
      initialValues={initialValues}
      update={config}
      onSuccess={(response) => successHandler(response)}
    >
      <Form form={form}>
        <Form.Item label={t('book.description.eable')} valuePropName="checked" name="descriptionEnable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('book.time.eable')} valuePropName="checked" name="timeEnable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('book.image.eable')} valuePropName="checked" name="imageEnable">
          <Switch />
        </Form.Item>
        <Form.Item label={t('book.default.expense.account')} name="defaultExpenseAccountId">
          <Select options={expenseAccounts} showArrow allowClear />
        </Form.Item>
        <Form.Item label={t('book.default.income.account')} name="defaultIncomeAccountId">
          <Select options={incomeAccounts} showArrow allowClear />
        </Form.Item>
        <Form.Item label={t('book.default.transfer.from.account')} name="defaultTransferFromAccountId">
          <Select options={transferFromAccounts} showArrow allowClear />
        </Form.Item>
        <Form.Item label={t('book.default.transfer.to.account')} name="defaultTransferToAccountId">
          <Select options={transferToAccounts} showArrow allowClear />
        </Form.Item>
        <Form.Item label={t('book.default.expense.category')} name="defaultExpenseCategoryId">
          <TreeSelect
            treeDataSimpleMode={true}
            treeData={expenseCategories}
            showArrow={true}
            showSearch={true}
            treeNodeFilterProp="title"
            allowClear={true} />
        </Form.Item>
        <Form.Item label={t('book.default.income.category')} name="defaultIncomeCategoryId">
          <TreeSelect
            treeDataSimpleMode={true}
            treeData={incomeCategories}
            showArrow={true}
            showSearch={true}
            treeNodeFilterProp="title"
            allowClear={true} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
