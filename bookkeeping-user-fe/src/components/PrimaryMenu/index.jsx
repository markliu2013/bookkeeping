import { Menu } from 'antd';
import { NavLink } from 'umi';
import { AreaChartOutlined, BankOutlined, AccountBookOutlined, SettingOutlined, CalendarOutlined } from '@ant-design/icons';
import t from '@/utils/translate';

import styles from './index.less';

export default () => {

  return (
    <Menu theme={"dark"} mode={"inline"} defaultOpenKeys={['sub1', 'sub2', 'sub3', 'sub4']} className={styles['menu']}>
      <Menu.SubMenu key="sub1" icon={<AreaChartOutlined />} title={t('menu.report')}>
        <Menu.Item key="11"><NavLink to='/dashboard'>{t('menu.overview')}</NavLink></Menu.Item>
        <Menu.Item key="12"><NavLink to='/reports/expense-category'>{t('menu.expense.category.reports')}</NavLink></Menu.Item>
        <Menu.Item key="13"><NavLink to='/reports/expense-tag'>{t('menu.expense.tag.reports')}</NavLink></Menu.Item>
        <Menu.Item key="14"><NavLink to='/reports/income-category'>{t('menu.income.category.reports')}</NavLink></Menu.Item>
        <Menu.Item key="15"><NavLink to='/reports/income-tag'>{t('menu.income.tag.reports')}</NavLink></Menu.Item>
        <Menu.Item key="16"><NavLink to='/reports/expense-income-trend'>{t('menu.flow.trend')}</NavLink></Menu.Item>
        <Menu.Item key="17"><NavLink to='/reports/balance-sheet'>{t('menu.balance.sheet')}</NavLink></Menu.Item>
        <Menu.Item key="18"><NavLink to='/reports/asset-debt-trend'>{t('menu.asset.trend')}</NavLink></Menu.Item>
      </Menu.SubMenu>
      <Menu.SubMenu key="sub2" icon={<BankOutlined />} title={t('menu.account.list')}>
        <Menu.Item key="21"><NavLink to='/checking-accounts'>{t('menu.checking.account')}</NavLink></Menu.Item>
        <Menu.Item key="22"><NavLink to='/credit-accounts'>{t('menu.credit.account')}</NavLink></Menu.Item>
        <Menu.Item key="23"><NavLink to='/debt-accounts'>{t('menu.debt.account')}</NavLink></Menu.Item>
        <Menu.Item key="24"><NavLink to='/asset-accounts'>{t('menu.asset.account')}</NavLink></Menu.Item>
        <Menu.Item key="26"><NavLink to='/accounts'>{t('menu.account.overview')}</NavLink></Menu.Item>
        <Menu.Item key="27"><NavLink to='/balance-logs'>{t('balance.log')}</NavLink></Menu.Item>
      </Menu.SubMenu>
      <Menu.SubMenu inlineCollapsed={false} key="sub3" icon={<AccountBookOutlined />} title={t('menu.bookkeeping')}>
        <Menu.Item key="31"><NavLink to='/expenses'>{t('menu.expense')}</NavLink></Menu.Item>
        <Menu.Item key="32"><NavLink to='/incomes'>{t('menu.income')}</NavLink></Menu.Item>
        <Menu.Item key="34"><NavLink to='/transfers'>{t('menu.transfer')}</NavLink></Menu.Item>
        <Menu.Item key="35"><NavLink to='/flows'>{t('menu.flow')}</NavLink></Menu.Item>
        <Menu.Item key="36"><NavLink to='/audit'>{t('menu.audit')}</NavLink></Menu.Item>
      </Menu.SubMenu>
      <Menu.Item key="61" icon={<CalendarOutlined />}><NavLink to='/items'>提醒管理</NavLink></Menu.Item>
      <Menu.SubMenu key="sub4" icon={<SettingOutlined />} title={t('menu.settings')}>
        <Menu.Item key="41"><NavLink to='/categories'>{t('menu.category')}</NavLink></Menu.Item>
        <Menu.Item key="45"><NavLink to='/books'>{t('menu.book')}</NavLink></Menu.Item>
        <Menu.Item key="46"><NavLink to='/groups'>{t('menu.group')}</NavLink></Menu.Item>
        <Menu.Item key="42">{t('menu.security')}</Menu.Item>
        <Menu.Item key="43">{t('menu.budget')}</Menu.Item>
        <Menu.Item key="44"><NavLink to='/scheduled'>{t('menu.schedule')}</NavLink></Menu.Item>
      </Menu.SubMenu>
    </Menu>
  );
};
