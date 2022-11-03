import {Col, Form, Input} from 'antd';
import {getDescriptionEnable} from "@/utils/util";
import t from "@/utils/translate";

export default () => {

  return (
    getDescriptionEnable() ?
      <Col flex="auto" style={{minWidth:300}}>
        <Form.Item label={t('description')} name="description">
          <Input allowClear={true} />
        </Form.Item>
      </Col> :
      null
  );

};
