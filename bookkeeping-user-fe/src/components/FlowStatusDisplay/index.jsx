import {useMemo} from "react";
import {Tag, Tooltip} from "antd";
import { history } from 'umi';
import {flowStatusToColor} from "@/utils/util";
import {getRefunds} from '@/services/deal';


export default (props) => {

  const { data } = props;

  const clickable = useMemo(() => data.status === 3 || data.amount < 0, [data]);

  async function clickHandler() {
    const response = await getRefunds(data.id);
    if (response && response.success) {
      history.push({
        pathname: history.pathname,
        query: {
          id: response.data.join(','),
        },
      });
    }
  }

  // TODO 多语言
  return (
    clickable ?
    <Tooltip title="点击查看对应退款记录">
      <Tag style={{cursor:"pointer", marginRight:0}} onClick={clickHandler} color={flowStatusToColor(data.status)}>{data.statusName}</Tag>
    </Tooltip>
      :
    <Tag style={{marginRight:0}} color={flowStatusToColor(data.status)}>{data.statusName}</Tag>
  );

}
