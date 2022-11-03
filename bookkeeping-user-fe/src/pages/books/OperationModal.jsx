import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Form, Input, Select, Switch} from 'antd';
import { create, update } from '@/services/book';
import {useResponseSelectData} from "@/utils/hooks";
import {getNull} from "@/utils/util";
import {nameRules, notesRules, requiredRules} from "@/utils/rules";
import FormModal from "@/components/FormModal";
import styles from './index.less';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const [initialValues, setInitialValues] = useState(currentItem)
  useEffect(() => {
    if (!visible) return;
    if (type === 1) {
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        ...{
          descriptionEnable: true,
          timeEnable: false,
          imageEnable: false,
        }
      });
    } else {
      setInitialValues({...getNull(form.getFieldsValue()), ...currentItem});
    }
  }, [visible]);

  function successHandler() {
    dispatch({ type: 'books/query' });
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + t('book')}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={successHandler}
    >
      <Form form={form} className={styles['form3']}>
        <Form.Item label={t('book.name')} name="name" rules={nameRules()}>
          <Input />
        </Form.Item>
        <Form.Item label={t('book.description.eable')} valuePropName="checked" name="descriptionEnable">
          <Switch disabled={type === 2} />
        </Form.Item>
        <Form.Item label={t('book.time.eable')} valuePropName="checked" name="timeEnable">
          <Switch disabled={type === 2} />
        </Form.Item>
        <Form.Item label={t('book.image.eable')} valuePropName="checked" name="imageEnable">
          <Switch disabled={type === 2} />
        </Form.Item>
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
