import {useMemo} from "react";
import {Form, Select} from 'antd';
import {accountRequiredRules} from "@/utils/rules";
import t from '@/utils/translate';

export default (props) => {

  const { data, name = "accountId", label=t('account'), required=true, onSelectChange } = props;

  // const messageBalance = t('account.balance');
  const accounts = useMemo(() => {
    if (data && data.length > 0) {
      return data.map(i => {
        return {
          value: i.id,
          //label: `${i.name} (${messageBalance}：${i.balance})`,
          label: i.name
        }
      });
    } else {
      return 0;
    }
  }, [data]);

  const changeHandler = (value) => {
    if (onSelectChange) onSelectChange(value);
  }

  return (
    <Form.Item label={label} name={name} rules={required ? accountRequiredRules() : null}>
      <Select options={accounts} showArrow showSearch filterOption optionFilterProp="label" allowClear={!required} onChange={changeHandler} />
    </Form.Item>
  );

};
