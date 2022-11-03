import {Checkbox, Col, Form, TreeSelect} from 'antd';
import t from '@/utils/translate';

export default (props) => {

  const { data, name = "tags", label = t('flow.tag') } = props;

  return (
    <Col flex="auto" style={{minWidth:300}}>
      <Form.Item label={label} name={name}>
        <TreeSelect
          treeDataSimpleMode={true}
          treeData={data}
          treeDefaultExpandAll={false}
          showCheckedStrategy={TreeSelect.SHOW_ALL}
          treeCheckStrictly={false}
          showArrow={true}
          showSearch={true}
          allowClear={true}
          treeNodeFilterProp="title"
          treeCheckable={true} />
      </Form.Item>
    </Col>
  );

};
