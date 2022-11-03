import {useEffect} from "react";
import {Col, Form, Input, Radio, Space} from 'antd';
import t from '@/utils/translate';

export default () => {
  return (
    <Col flex="290px">
      <Form.Item label={t('amount.between')}>
        <Space>
          <span>
            <Form.Item name="minAmount" noStyle={true}>
              <Input style={{ width: 90 }}/>
            </Form.Item>
            <span> ~ </span>
            <Form.Item name="maxAmount" noStyle={true}>
              <Input style={{ width: 90 }}/>
            </Form.Item>
          </span>
        </Space>
      </Form.Item>
    </Col>
  );
};
