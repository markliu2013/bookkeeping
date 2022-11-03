import {useEffect, useState} from "react";
import {DatePicker, Radio, Space} from "antd";
import {radioValueToTimeRange} from '@/utils/util';
import t from '@/utils/translate';


export default (props) => {

  const { value, onChange } = props;

  const [ rangePickerValue, setRangePickerValue ] = useState([]);

  useEffect(() => {
    setRangePickerValue(radioValueToTimeRange(value));
  }, [value]);

  function radioChangeHandler(e) {
    onChange(e.target.value);
  }

  return <Space>
    <Radio.Group value={value} onChange={radioChangeHandler}>
      <Radio.Button value={7}>{t('in.30.days')}</Radio.Button>
      <Radio.Button value={8}>{t('in.1.year')}</Radio.Button>
      <Radio.Button value={3}>{t('this.month')}</Radio.Button>
      <Radio.Button value={4}>{t('this.year')}</Radio.Button>
      <Radio.Button value={5}>{t('last.year')}</Radio.Button>
    </Radio.Group>
    <DatePicker.RangePicker disabled={true} allowClear={false} value={rangePickerValue} showTime={false} format="YYYY-MM-DD" />
  </Space>
}
