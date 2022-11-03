import { useDispatch, useSelector } from 'umi';
import { Radio, Button, Space } from 'antd';
import {PlusOutlined, ReloadOutlined} from "@ant-design/icons";
import CheckingAccountModal from './CheckingAccountModal';
import CreditAccountModal from './CreditAccountModal';
import DebtAccountModal from './DebtAccountModal';
import AssetAccountModal from './AssetAccountModal';
import t from '@/utils/translate';

export default () => {

  const dispatch = useDispatch();
  const { currentAccountType } = useSelector(state => state.accounts);

  const options = [
    { label: t('menu.checking.account'), value: 1 },
    { label: t('menu.credit.account'), value: 2 },
    { label: t('menu.debt.account'), value: 3 },
    { label: t('menu.asset.account'), value: 4 },
  ];

  const typeChangeHandler = (e) => {
    dispatch({ type: 'accounts/updateState', payload: { currentAccountType: e.target.value }})
  }

  const addAccountHandler = () => {
    switch (currentAccountType) {
      case 1:
        dispatch({ type: 'modal/show', payload: {component: CheckingAccountModal, type: 1, currentItem: { } }});
        break;
      case 2:
        dispatch({ type: 'modal/show', payload: {component: CreditAccountModal, type: 1, currentItem: { } }});
        break;
      case 3:
        dispatch({ type: 'modal/show', payload: {component: DebtAccountModal, type: 1, currentItem: { } }});
        break;
      case 4:
        dispatch({ type: 'modal/show', payload: {component: AssetAccountModal, type: 1, currentItem: { } }});
        break;
    }
  }

  const refreshHandler = () => {
    dispatch({ type: 'accounts/refresh' });
  }

  return (
    <Space size="large">
      <Radio.Group
        size="large"
        onChange={typeChangeHandler}
        options={options}
        value={currentAccountType}
        optionType="button"
        buttonStyle="solid" />
      <Button size="large" type="primary" icon={<PlusOutlined />} onClick={ addAccountHandler }>{t('new')}</Button>
      <Button size="large" type="primary" icon={<ReloadOutlined />} onClick={ refreshHandler }>{t('reload')}</Button>
    </Space>
  )

}
