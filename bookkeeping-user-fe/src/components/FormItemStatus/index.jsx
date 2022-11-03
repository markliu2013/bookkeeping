import {Col, Form, Select} from 'antd';
import t from "@/utils/translate";

export default () => {

  return (
    <Col flex="200px">
      <Form.Item label={t('flow.status')} name="status">
        <Select allowClear={true}>
          <Select.Option value={1}>{t('flow.status1')}</Select.Option>
          <Select.Option value={2}>{t('flow.status2')}</Select.Option>
          <Select.Option value={3}>{t('flow.status3')}</Select.Option>
        </Select>
      </Form.Item>
    </Col>
  );

};
