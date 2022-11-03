import {Col, Row, Space} from "antd";
import {spaceVProp} from "@/utils/var";
import Breadcrumb from "@/components/Breadcrumb";
import AssetCategory from './AssetCategory'
import DebtCategory from './DebtCategory'
import t from "@/utils/translate";

export default () => {
  return (
    <Space {...spaceVProp}>
      <Breadcrumb data={[t('menu.report'), t('menu.balance.sheet')]} />
      <Row gutter={8}>
        <Col span={12}>
          <AssetCategory />
        </Col>
        <Col span={12}>
          <DebtCategory />
        </Col>
      </Row>
    </Space>
  )
}
