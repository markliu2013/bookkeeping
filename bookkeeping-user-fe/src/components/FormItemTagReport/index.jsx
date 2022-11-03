import {Checkbox, Col, Form, TreeSelect} from 'antd';
import t from '@/utils/translate';

export default (props) => {

  const { data, name = "tags", label = t('flow.tag') } = props;

  const normFile = (e) => {
    if (Array.isArray(e)) {
      return e.map(i=>i.value);
    }
  };

  return (
    <Col flex="auto" style={{minWidth:300}}>
      <Form.Item label={label} name={name} getValueFromEvent={normFile}>
        <TreeSelect
          treeDataSimpleMode={true}
          treeData={data}
          treeDefaultExpandAll={false}
          showCheckedStrategy={TreeSelect.SHOW_ALL}
          treeCheckStrictly={true}
          showArrow={true}
          showSearch={true}
          allowClear={true}
          treeNodeFilterProp="title"
          treeCheckable={true} />
      </Form.Item>
    </Col>
  );

};
