import { Input } from 'antd';

export default (props) => {

  const { amount: value, positive = 0, onBlur:blurHandler, onChange: changeHandler} = props;

  const onChange = e => {
    const { value } = e.target;
    const reg = /^-?\d{1,9}(\.\d{0,2})?$/;
    if (positive && value === '-') {
      changeHandler('');
      return false;
    }
    if ((!isNaN(value) && reg.test(value)) || value === '' || value === '-') {
      changeHandler(value);
    }

  };

  // '.' at the end or only '-' in the input box.
  const onBlur = e => {
    if (value) {
      let valueTemp = value;
      if (value.charAt(value.length - 1) === '.' || value === '-') {
        valueTemp = value.slice(0, -1);
      }
      changeHandler(valueTemp.replace(/0*(\d+)/, '$1'));
    }
    if (blurHandler) {
      blurHandler();
    }
  };


  return (
      <Input
        {...props}
        value={value}
        onChange={onChange}
        onBlur={onBlur}
        placeholder="请输入数字"
        maxLength={12}
      />
  );
};
