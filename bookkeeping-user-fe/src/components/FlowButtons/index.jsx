import {Button, Space} from "antd";
import { PlusOutlined } from '@ant-design/icons';
import {showFlowModal} from '@/utils/flow';
import t from '@/utils/translate';

export default () => {

  return (
    <Space size="large">
      <Button type="primary" size="large" icon={<PlusOutlined />} onClick={()=>showFlowModal(1, 1, {})}>{t('new') + t('expense')}</Button>
      <Button type="primary" size="large" icon={<PlusOutlined />} onClick={()=>showFlowModal(2, 1, {})}>{t('new') + t('income')}</Button>
      <Button type="primary" size="large" icon={<PlusOutlined />} onClick={()=>showFlowModal(3, 1, {})}>{t('new') + t('transfer')}</Button>
    </Space>
  );

};
