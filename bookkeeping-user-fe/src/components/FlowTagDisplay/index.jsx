import {useState} from "react";
import {Tag, Tooltip} from "antd";
import {useDispatch} from "umi";
import TagModal from './TagModal';
import t from "@/utils/translate";

export default (props) => {

  const { data, record } = props;
  const dispatch = useDispatch();

  const updateTagAmountHandler = () => {
    dispatch({ type: 'modal/show', payload: {component: TagModal, type: 2, currentItem: {currencyCode: record.currencyCode, ...data} } });
  }

  // TODO 多语言
  return (
    record.categoryName || record.type === 1 || record.type === 2 ?
    <Tooltip title={`金额: ${data.amount}, 点击修改`}><Tag onClick={updateTagAmountHandler} style={{cursor:"pointer"}} color="blue">{data.tagName}</Tag></Tooltip>
      :
    <Tag color="blue">{data.tagName}</Tag>
  );

}
