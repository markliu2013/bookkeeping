import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import { Form, Input, TreeSelect, message } from 'antd';
import { create, update } from '@/services/expense-category';
import { useCategoryTreeSelectData } from "@/utils/hooks";
import {getNull, validateForm} from "@/utils/util";
import FormModal from "@/components/FormModal";
import {nameRules, notesRules} from "@/utils/rules";
import t from "@/utils/translate";
import styles from './index.less';

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const { querySimpleResponse : categoryResponse } = useSelector(state => state.expenseCategory);
  const [treeData] = useCategoryTreeSelectData(categoryResponse);
  useEffect(() => {
    if (visible) {
      if (!categoryResponse) dispatch({ type: 'expenseCategory/fetchSimple' });
    }
  }, [visible]);

  const [initialValues, setInitialValues] = useState({})
  useEffect(() => {
    if (visible) {
      if (type === 1) {
        setInitialValues({
          ...getNull(form.getFieldsValue()),
          ...{
            parentId: currentItem && currentItem.id ? currentItem.id : null,
          }
        });
      } else {
        setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
      }
    }
  }, [visible]);

  function successHandler() {
    dispatch({ type: 'categories/queryExpenseCategory' });
    dispatch({ type: 'expenseCategory/refresh' });
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + t('expense.category')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={successHandler}
    >
      <Form form={form} className={styles['form']}>
        <Form.Item label={t('parent.category')} name="parentId">
          <TreeSelect
            allowClear={true}
            treeDataSimpleMode={true}
            treeData={treeData}
            showArrow={true}
            showSearch={true}
            treeNodeFilterProp="title"
            treeDefaultExpandAll={false} />
        </Form.Item>
        <Form.Item label={t('name')} name="name" rules={nameRules()}>
          <Input />
        </Form.Item>
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
