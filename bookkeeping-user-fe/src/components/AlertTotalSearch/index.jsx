import { Alert } from 'antd';

export default (props) => {

  const { message } = props;

  return (
    <Alert style={{display:'inline-flex', paddingTop:0, paddingBottom:0}} message={message} type="info" showIcon />
  );
};
