import {DatePicker, Form} from 'antd';
import {timeRequiredRules} from "@/utils/rules";
import {getTimeEnable, getTimeFormat} from "@/utils/util";
import t from "@/utils/translate";

export default () => {

  return (
    <Form.Item label={t('flow.createTime')} name="createTime" rules={timeRequiredRules()}>
      <DatePicker showTime={getTimeEnable()} format={getTimeFormat()} allowClear={false} />
    </Form.Item>
  );

};
