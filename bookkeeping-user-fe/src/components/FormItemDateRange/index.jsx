import {Col, DatePicker, Form, Radio, Space} from 'antd';
import {useEffect} from "react";
import {radioValueToTimeRange,getTimeFormat} from "@/utils/util";
import t from "@/utils/translate";

export default (props) => {

  const { form, dateRadioValue, setDateRadioValue } = props;

  function createTimeRadioChangeHandler(e) {
    setDateRadioValue(e.target.value);
  }
  useEffect(() => {
    form.setFieldsValue({
      'createTimeRange': radioValueToTimeRange(dateRadioValue),
    });
  }, [dateRadioValue]);

  return (
    <Col flex="670px">
      <Form.Item label={t('time.between')}>
        <Space>
          <Form.Item name="createTimeRange" noStyle={true}>
            <DatePicker.RangePicker showTime={false} format='YYYY-MM-DD' />
          </Form.Item>
          <Radio.Group size="small" onChange={createTimeRadioChangeHandler} value={dateRadioValue}>
            <Radio.Button value={1}>{t('today')}</Radio.Button>
            <Radio.Button value={2}>{t('this.week')}</Radio.Button>
            <Radio.Button value={3}>{t('this.month')}</Radio.Button>
            <Radio.Button value={4}>{t('this.year')}</Radio.Button>
            <Radio.Button value={5}>{t('last.year')}</Radio.Button>
            <Radio.Button value={6}>{t('in.7.days')}</Radio.Button>
            <Radio.Button value={7}>{t('in.30.days')}</Radio.Button>
            <Radio.Button value={8}>{t('in.1.year')}</Radio.Button>
          </Radio.Group>
        </Space>
      </Form.Item>
    </Col>
  );
};
