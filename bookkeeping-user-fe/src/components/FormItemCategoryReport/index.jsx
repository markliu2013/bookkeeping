import {Col, Form, TreeSelect} from 'antd';
import t from '@/utils/translate';

export default (props) => {

  const { data } = props;

  return (
    <Col flex="200px">
      <Form.Item label={t('category')} name="categoryId">
        <TreeSelect
          treeDataSimpleMode={true}
          treeData={data}
          showArrow={true}
          showSearch={true}
          allowClear={true}
          treeNodeFilterProp="title"
          treeDefaultExpandAll={false} />
      </Form.Item>
    </Col>
  );

};
