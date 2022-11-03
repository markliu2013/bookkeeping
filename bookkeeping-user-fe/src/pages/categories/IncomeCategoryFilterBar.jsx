import {Button, Col, Form, Input, Row, Select, Space} from "antd";
import {useDispatch} from "umi";
import {filterFormProp} from "@/utils/var";
import t from "@/utils/translate";

export default () => {

  const [form] = Form.useForm();
  const dispatch = useDispatch();

  async function resetHandler() {
    form.resetFields();
    const values = await form.validateFields();
    dispatch({ type: 'categories/updateState', payload: {incomeCategoryQueryData: values} });
  }

  async function searchHandler(form) {
    const values = await form.validateFields();
    dispatch({ type: 'categories/queryIncomeCategory', payload: values });
    dispatch({ type: 'categories/updateState', payload: {incomeCategoryQueryData: values} });
  }

  return (
    <Form {...filterFormProp} form={form} size="small">
      <Row gutter={20}>
        <Col flex="300px">
          <Form.Item label={t('name')} name="name">
            <Input allowClear={true} />
          </Form.Item>
        </Col>
        <Col flex="200px">
          <Form.Item label={t('is.enable')} name="enable">
            <Select allowClear={true}>
              <Select.Option value={true}>{t('yes')}</Select.Option>
              <Select.Option value={false}>{t('no')}</Select.Option>
            </Select>
          </Form.Item>
        </Col>
      </Row>
      <Row gutter={20} justify="end">
        <Col span={24} style={{textAlign: "right"}}>
          <Space>
            <Button type="primary" size="small" onClick={()=>searchHandler(form)}>{t('search')}</Button>
            <Button type="primary" size="small" onClick={resetHandler}>{t('form.reset')}</Button>
          </Space>
        </Col>
      </Row>
    </Form>
  )
}
