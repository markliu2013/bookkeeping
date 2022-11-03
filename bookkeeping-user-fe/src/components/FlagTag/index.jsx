import { Tag } from "antd";
import { CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';
import t from "@/utils/translate";

export default (props) => {

  return (
    props.value ?
      <Tag icon={<CheckCircleOutlined />} color="success" style={{marginRight: 0}}>{t('yes')}</Tag> :
      <Tag icon={<CloseCircleOutlined />} color="error" style={{marginRight: 0}}>{t('no')}</Tag>
  );

};
