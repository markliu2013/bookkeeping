import {Form, Input} from 'antd';
import {getDescriptionEnable} from "@/utils/util";
import t from "@/utils/translate";

export default () => {

  return (
    getDescriptionEnable() ?
      <Form.Item label={t('description')} name="description">
        <Input />
      </Form.Item> :
      null
  );

};
