import {Form, Row, Col, Button, Space} from 'antd';
import { filterFormProp } from "@/utils/var";
import { searchHandler } from "@/utils/util";
import FormItemDateRange from "@/components/FormItemDateRange";
import t from '@/utils/translate';
import {useState} from "react";
import {useSelector} from "umi";

export default () => {

  const [form] = Form.useForm();
  const loading = useSelector(state => state.loading.effects['assetDebtTrendReports/query']);

  const [dateRadioValue, setDateRadioValue] = useState(8);
  function resetHandler() {
    setDateRadioValue();
    form.resetFields();
  }

  return (
    <Form {...filterFormProp} form={form}>
      <Row gutter={8}>
        <FormItemDateRange form={form} dateRadioValue={dateRadioValue} setDateRadioValue={setDateRadioValue} />
      </Row>
      <Row>
        <Col flex="auto" style={{ textAlign:'right' }}>
          <Space>
            <Button type="primary" loading={loading} onClick={()=>searchHandler(form)}>{t('search')}</Button>
            <Button type="primary" onClick={resetHandler}>{t('form.reset')}</Button>
          </Space>
        </Col>
      </Row>
    </Form>
  );

};
