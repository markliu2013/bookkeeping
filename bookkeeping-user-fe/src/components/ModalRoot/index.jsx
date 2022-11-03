import {useSelector} from "umi";

export default () => {

  const { component: Component } = useSelector(state => state.modal);

  return (
    Component ? <Component /> : null
  );

};
