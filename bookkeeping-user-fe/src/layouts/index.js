import UserLayout from './UserLayout';
import BasicLayout from './BasicLayout';

export default (props) => {
  if (props.location.pathname === '/signin' || props.location.pathname === '/register') {
    return <UserLayout>{ props.children }</UserLayout>
  }
  return <BasicLayout>{ props.children }</BasicLayout>
}
