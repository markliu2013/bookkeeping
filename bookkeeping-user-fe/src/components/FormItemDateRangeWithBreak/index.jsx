import {Col, DatePicker, Form, Radio, Row, Select, Space} from 'antd';
import {useEffect, useState} from "react";
import {radioValueToTimeRange,getTimeFormat,getTimeEnable} from "@/utils/util";
import t from "@/utils/translate";

export default (props) => {

  const { form, dateRadioValue, setDateRadioValue } = props;

  function createTimeRadioChangeHandler(e) {
    setDateRadioValue(e.target.value);
  }
  useEffect(() => {
    form.setFieldsValue({
      'createTimeRange': radioValueToTimeRange(dateRadioValue),
      'breakType': breakType
    });
  }, [dateRadioValue]);

  const [breakType, setBreakType] = useState("month");

  return (
    <Row gutter={8}>
      <Col flex="600px">
        <Form.Item label={t('time.between')}>
          <Space>
            <Form.Item name="createTimeRange" noStyle={true}>
              <DatePicker.RangePicker picker={breakType} allowClear={false} />
            </Form.Item>
            <Radio.Group size="small" onChange={createTimeRadioChangeHandler} value={dateRadioValue}>
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
      <Col flex="250px">
        <Form.Item label={t('report.break.down.label')} name="breakType">
          <Select defaultValue={breakType} value={breakType} onChange={(value) => setBreakType(value)}>
            <Select.Option value="day">{t('unit.days')}</Select.Option>
            {/*周的计算有问题，如果一年的第一天不是周一，antd的计算和java不同*/}
            {/*<Select.Option value="week">{t('unit.weeks')}</Select.Option>*/}
            <Select.Option value="month">{t('unit.months')}</Select.Option>
            <Select.Option value="quarter">{t('unit.quarters')}</Select.Option>
            <Select.Option value="year">{t('unit.years')}</Select.Option>
          </Select>
        </Form.Item>
      </Col>
    </Row>
  );
};
