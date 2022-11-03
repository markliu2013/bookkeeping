import {getDvaApp, useDispatch} from "umi";
import ExpenseModal from '@/components/ExpenseModal';
import IncomeModal from '@/components/IncomeModal';
import TransferModal from '@/components/TransferModal';
import AdjustBalanceModal from '@/components/AdjustBalanceModal';
import t from "@/utils/translate";
import FlowImageUploadModal from "@/components/FlowImageUploadModal";

export function showFlowModal(flowType, modalType, currentItem) {
  const dispatch = getDvaApp()._store.dispatch;
  switch (flowType) {
    case 1:
      dispatch({ type: 'modal/show', payload: {component: ExpenseModal, type: modalType, currentItem: currentItem }});
      break;
    case 2:
      dispatch({ type: 'modal/show', payload: {component: IncomeModal, type: modalType, currentItem: currentItem }});
      break;
    case 3:
      dispatch({ type: 'modal/show', payload: {component: TransferModal, type: modalType, currentItem: currentItem }});
      break;
    case 4:
      dispatch({ type: 'modal/show', payload: {component: AdjustBalanceModal, type: modalType, currentItem: currentItem }});
      break;
  }
}

export function imageHandler(record) {
  const dispatch = getDvaApp()._store.dispatch;
  dispatch({ type: 'modal/show', payload: {component: FlowImageUploadModal, type: 2, currentItem: record } });
}
