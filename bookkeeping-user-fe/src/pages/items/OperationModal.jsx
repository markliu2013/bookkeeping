import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'umi';
import {Modal, Form, Input, message, DatePicker, Select} from 'antd';
import { create, update } from '@/services/item';
import {getNull, getTimeEnable, getTimeFormat, validateForm} from "@/utils/util";
import t from "@/utils/translate";
import FormModal from "@/components/FormModal";
import {nameRules, notesRules, timeRequiredRules, timeRangeRequiredRules, requiredRules} from "@/utils/rules";
import styles from './index.less';
import moment from "moment";

export default () => {

  const dispatch = useDispatch();
  const [form] = Form.useForm();

  const { visible, type, currentItem } = useSelector(state => state.modal);

  const [initialValues, setInitialValues] = useState(currentItem);
  useEffect(() => {
    if (!visible) return;
    if (type === 1) {
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        'type': 1,
        'repeatType': 2,
        'interval': 1
      });
      setRepeatFlag(1);
    } else {
      let currentItemCopy = JSON.parse(JSON.stringify(currentItem));
      currentItemCopy.startDate = moment(currentItemCopy.startDate);
      currentItemCopy.endDate = moment(currentItemCopy.endDate);
      currentItemCopy.dateRange = [currentItemCopy.startDate, currentItemCopy.endDate];
      const repeatFlag = currentItemCopy.repeatType == 0 ? 1 : 2;
      setInitialValues({
        ...getNull(form.getFieldsValue()),
        ...currentItemCopy,
        'type': repeatFlag,
      });
      setRepeatFlag(repeatFlag);
    }
  }, [visible, type, currentItem]);

  const [repeatFlag, setRepeatFlag] = useState(1);

  function successHandler() {
    dispatch({ type: 'items/query' });
  }

  function parseValues(values) {
    if (values.startDate) values.startDate = values.startDate.valueOf();
    if (values.dateRange && values.dateRange[0]) {
      values.startDate = values.dateRange[0].valueOf();
    }
    if (values.dateRange && values.dateRange[1]) {
      values.endDate = values.dateRange[1].valueOf();
    }
    delete values.dateRange;
  }

  return (
    <FormModal
      title={(type === 1 ? t('new') : t('update')) + '提醒事项'}
      form={form}
      initialValues={initialValues}
      create={create}
      update={update}
      onSuccess={successHandler}
      onParseValues={parseValues}
    >
      <Form form={form} className={styles['form2']}>
        <Form.Item label="类型" name="type" rules={requiredRules()}>
          <Select disabled={type === 2} value={repeatFlag} onChange={(value) => setRepeatFlag(value)}>
           <Select.Option value={1}>单次</Select.Option>
           <Select.Option value={2}>多次</Select.Option>
          </Select>
        </Form.Item>
        <Form.Item label='标题' name="title" rules={nameRules()}>
          <Input />
        </Form.Item>
        {repeatFlag == 1
            ? <Form.Item label='执行日期' name="startDate" rules={timeRequiredRules()}>
                <DatePicker disabled={type === 2} showTime={false} format='YYYY-MM-DD' allowClear={false}/>
              </Form.Item>
            : <div>
                <Form.Item label='起止日期' name="dateRange" rules={timeRangeRequiredRules()}>
                  <DatePicker.RangePicker disabled={[type === 2, false]} showTime={false} format='YYYY-MM-DD' />
                </Form.Item>
                <Form.Item label='间隔周期类型' name="repeatType" rules={requiredRules()}>
                  <Select disabled={type === 2}>
                    <Select.Option value={1}>天</Select.Option>
                    <Select.Option value={2}>月</Select.Option>
                    <Select.Option value={3}>年</Select.Option>
                  </Select>
                </Form.Item>
                <Form.Item label='间隔周期数' name="interval" rules={requiredRules()}>
                  <Input disabled={type === 2} />
                </Form.Item>
              </div>
        }
        <Form.Item label={t('notes')} name="notes" rules={notesRules()}>
          <Input.TextArea rows={4} />
        </Form.Item>
      </Form>
    </FormModal>
  );
}
