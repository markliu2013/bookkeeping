import {Col, Form, Select} from 'antd';
import t from '@/utils/translate';

export default (props) => {

  const { data, name = "accounts", label=t('account') } = props;

  return (
    <Col flex="auto" style={{minWidth:300}}>
      <Form.Item label={label} name={name}>
        <Select mode="multiple" options={data} allowClear showArrow showSearch filterOption optionFilterProp={"label"} />
      </Form.Item>
    </Col>
  );

};
