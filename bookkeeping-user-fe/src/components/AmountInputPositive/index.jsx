import { Input } from 'antd';

export default (props) => {

  const onChange = e => {
    const { value } = e.target;
    const reg = /^-?\d{1,9}(\.\d{0,2})?$/;
    if (value !== '-') {
      if ((!isNaN(value) && reg.test(value)) || value === '' || value === '-') {
        props.onChange(value);
      }
    }
  };

  // '.' at the end or only '-' in the input box.
  const onBlur = () => {
    const { value1:value, onBlur, onChange } = props;
    let valueTemp = value;
    if (value.charAt(value.length - 1) === '.' || value === '-') {
      valueTemp = value.slice(0, -1);
    }
    onChange(valueTemp.replace(/0*(\d+)/, '$1'));
    if (onBlur) {
      onBlur();
    }
  };


  return (
    <Input
      {...props}
      value={props.value1}
      onChange={onChange}
      onBlur={onBlur}
      placeholder="请输入数字"
      maxLength={12}
    />
  );
};
