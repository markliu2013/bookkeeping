// 暂时没用到
import { Spin } from 'antd';
import { LoadingOutlined } from '@ant-design/icons';

export default () => {
  const antIcon = <LoadingOutlined style={{ fontSize: 12 }} spin />;
  return (
    <Spin size="small" indicator={antIcon} />
  );
};
