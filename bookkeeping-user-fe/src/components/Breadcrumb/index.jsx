import { Breadcrumb } from 'antd';

export default (props) => {
  return (
    <Breadcrumb>
      { props.data.map((item, index) => <Breadcrumb.Item key={index}>{item}</Breadcrumb.Item>) }
    </Breadcrumb>
  );
};
