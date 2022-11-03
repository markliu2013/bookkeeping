import {Button, Col, Form, Input, Row, Select, TreeSelect, Space} from 'antd';
import {MinusCircleOutlined, PlusOutlined, PlusCircleOutlined} from "@ant-design/icons";
import {categoryRequiredRules, amountRequiredRules} from "@/utils/rules";
import t from '@/utils/translate';
import {useIntl} from "umi";
import styles from './index.less';

export default (props) => {

  const { categories, isConvert = false, currency } = props;

  const intl = useIntl();
  const categoryRequired = categoryRequiredRules();
  const amountRequired = amountRequiredRules();
  return (
    <Form.List name="categories">
      {(fields, { add, remove }) => {
        return (
          <>
            {fields.map((field) => (
              <Row key={field.key} gutter={8} className={styles['row']}>
                <Col flex="auto">
                  <Form.Item
                    {...field}
                    label={intl.formatMessage({id:'category'})}
                    rules={categoryRequired}
                    name={[field.name, 'categoryId']}
                    fieldKey={[field.fieldKey, 'categoryId']}>
                    <TreeSelect
                      treeDataSimpleMode={true}
                      treeData={categories}
                      showArrow={true}
                      showSearch={true}
                      treeNodeFilterProp="title"
                      treeDefaultExpandAll={true} />
                  </Form.Item>
                </Col>
                <Col flex="150px" className={styles['amount-col']}>
                  <Form.Item
                    {...field}
                    label={intl.formatMessage({id:'amount'})}
                    labelCol={{span:5}}
                    rules={amountRequired}
                    name={[field.name, 'amount']}
                    fieldKey={[field.fieldKey, 'amount']}>
                    <Input />
                  </Form.Item>
                </Col>
                {
                  isConvert ?
                    <Col flex="150px" className={styles['convert-amount-col']}>
                      <Form.Item
                        {...field}
                        label={currency}
                        labelCol={{span:9}}
                        rules={amountRequired}
                        name={[field.name, 'convertedAmount']}
                        fieldKey={[field.fieldKey, 'convertedAmount']}>
                        <Input />
                      </Form.Item>
                    </Col> : null
                }
                <Col flex="25px">
                  <Space>
                    <PlusCircleOutlined onClick={() => add()} />
                    {fields.length > 1 ? (
                      <MinusCircleOutlined onClick={() => remove(field.name)} />
                    ) : null}
                  </Space>
                </Col>
              </Row>
            ))}
          </>
        );
      }}
    </Form.List>
  );

};
