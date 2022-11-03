import {useEffect, useState} from "react";
import {useFocus} from "@/utils/hooks";
import {useDispatch} from "umi";
import {Button, Checkbox, Col, Form, Input, message, Row, Tag, TreeSelect,Modal} from 'antd';
import {PlusOutlined} from "@ant-design/icons";
import AddTagModal from './AddTagModal';
import t from '@/utils/translate';

export default (props) => {

  const dispatch = useDispatch();
  const { data, type } = props;

  const normFile = (e) => {
    if (Array.isArray(e)) {
      return e.map(i=>i.value);
    }
  };

  function addHandler() {
    setVisible(true);
  }

  function hide() {
    setVisible(false);
  }

  const [visible, setVisible] = useState(false);

  return (
    <Row gutter={20}>
      <Col flex="auto">
        <Form.Item label={t('flow.tag')} name="tags" getValueFromEvent={normFile}>
          <TreeSelect
            treeDataSimpleMode={true}
            treeData={data}
            multiple={true}
            treeCheckable={true}
            treeCheckStrictly={true}
            labelInValue={false}
            showArrow={true}
            showSearch={true}
            treeNodeFilterProp="title"
            treeDefaultExpandAll={false} />
        </Form.Item>
      </Col>
      <Col flex="50px" style={{ marginLeft: 'auto' }}>
        <Button icon={<PlusOutlined />} type="link" onClick={addHandler}>{t('new') + t('flow.tag')}</Button>
        <AddTagModal visible={visible} onHide={hide} type={type} />
      </Col>
    </Row>
  );

};
