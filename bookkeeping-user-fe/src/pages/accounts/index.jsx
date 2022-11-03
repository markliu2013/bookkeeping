import { useEffect } from "react";
import { Space } from 'antd';
import { useDispatch, useSelector } from 'umi';
import Breadcrumb from '@/components/Breadcrumb';
import { spaceVProp }  from '@/utils/var';
import OperationBar from './OperationBar';
import CheckingAccountTable from './CheckingAccountTable';
import CreditAccountTable from './CreditAccountTable';
import DebtAccountTable from './DebtAccountTable';
import AssetAccountTable from './AssetAccountTable';
import t from "@/utils/translate";

export default () => {

  const dispatch = useDispatch();
  const { currentAccountType } = useSelector(state => state.accounts);

  const tableSwitch = (type) => {
    switch(type) {
      case 1:
        return <CheckingAccountTable />;
      case 2:
        return <CreditAccountTable />;
      case 3:
        return <DebtAccountTable />;
      case 4:
        return <AssetAccountTable />;
    }
  }

  return (
    <Space {...spaceVProp} size="large">
      <Breadcrumb data={[t('menu.account.list'), t('menu.account.overview')]} />
      <OperationBar />
      { tableSwitch(currentAccountType) }
    </Space>
  );

}
