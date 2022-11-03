import { useDispatch, useSelector } from 'umi';
import { Radio, Button, Space } from 'antd';
import { PlusOutlined } from "@ant-design/icons";
import ExpenseCategoryModal from './ExpenseCategoryModal';
import IncomeCategoryModal from './IncomeCategoryModal';
import TagModal from './TagModal';
import PayeeModal from './PayeeModal';
import t from '@/utils/translate';

export default () => {

  const dispatch = useDispatch();
  const { currentCategoryType } = useSelector(state => state.categories);

  const options = [
    { label: t('expense.category'), value: 1 },
    { label: t('income.category'), value: 2 },
    { label: t('tag'), value: 3 },
    { label: t('payee'), value: 4 },
  ];

  const typeChangeHandler = (e) => {
    dispatch({ type: 'categories/updateState', payload: { currentCategoryType: e.target.value }})
  }

  const addHandler = () => {
    switch (currentCategoryType) {
      case 1:
        dispatch({ type: 'modal/show', payload: {component: ExpenseCategoryModal, type: 1, currentItem: {} }});
        break;
      case 2:
        dispatch({ type: 'modal/show', payload: {component: IncomeCategoryModal, type: 1, currentItem: {} }});
        break;
      case 3:
        dispatch({ type: 'modal/show', payload: {component: TagModal, type: 1, currentItem: {} }});
        break;
      case 4:
        dispatch({ type: 'modal/show', payload: {component: PayeeModal, type: 1, currentItem: {} }});
        break;
    }
  }

  return (
    <Space size="large">
      <Radio.Group
        size="large"
        onChange={typeChangeHandler}
        options={options}
        value={currentCategoryType}
        optionType="button"
        buttonStyle="solid" />
      <Button size="large" type="primary" onClick={addHandler} icon={<PlusOutlined />}>{t('new')}</Button>
    </Space>
  )

}
