import { useIntl, setLocale } from 'umi';

export default (id, args) => {

  const intl = useIntl();

  // setLocale('en-US', true);
  // setLocale('zh-CN', true);

  return intl.formatMessage({id:id}, {...args});

}
