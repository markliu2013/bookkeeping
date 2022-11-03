import { useDispatch } from 'umi';
import { Button } from 'antd';
import OperationModal from './OperationModal';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();

  const addHandler = () => {
    dispatch({ type: 'modal/show', payload: {component: OperationModal, type: 1, currentItem: null }});
  }

  return (
    <Button type="primary" onClick={ addHandler }>{t('new')}</Button>
  )

}
