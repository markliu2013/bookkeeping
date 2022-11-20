import {history, useIntl, getDvaApp} from 'umi';
import moment from 'moment';

export function tableSortFormat(sorter) {
  let orderDir = '';
  if (sorter && sorter.field && sorter.order) {
    orderDir = sorter.field;
    if (sorter.order === 'ascend') {
      orderDir += ',asc'
    } else if (sorter.order === 'descend') {
      orderDir += ',desc'
    }
  }
  return orderDir;
}

export function handleTableChange(pagination, _, sorter) {
  const { query, pathname } = history.location;
  const newQuery = Object.assign({}, query, {
    page: pagination.current,
    size: pagination.pageSize,
    sort: tableSortFormat(sorter),
  });
  history.push({
    pathname: pathname,
    query: newQuery
  });
}

export function paginationChange(page, pageSize) {
  const { query, pathname } = history.location;
  const newQuery = Object.assign({}, query, {
    page: page,
    size: pageSize,
  });
  history.push({
    pathname: pathname,
    query: newQuery
  });
}

export function tableChangeQueryFormat(pagination, sorter) {
  return {
    page: pagination.current,
    size: pagination.pageSize,
    sort: tableSortFormat(sorter),
  }
}

function offSpring(categories, category) {
  return categories.reduce((r, item) => {
    if (item.pId === category.value) {
      r.push(item, ...offSpring(categories, item));
    }
    return r;
  }, []);
}

function parseCreateTimeRange(values) {
  if (values.createTimeRange && values.createTimeRange[0]) {
    values.minTime = values.createTimeRange[0].valueOf();
  }
  if (values.createTimeRange && values.createTimeRange[1]) {
    values.maxTime = values.createTimeRange[1].valueOf();
  }
  delete values.createTimeRange;
}

export async function searchHandler(form) {
  const values = await form.validateFields();
  parseCreateTimeRange(values);
  history.push({
    pathname: location.pathname,
    query: values
  });
}

export async function searchHandlerWithCategory(form) {
  const values = await form.validateFields();
  parseCreateTimeRange(values);
  // if (values.categories) {
  //   let offSpringCategories = values.categories.map(item => offSpring(categories, item));
  //   offSpringCategories = offSpringCategories.flat();
  //   values.categories = [...(values.categories.map(item => item.value)), ...(offSpringCategories.map(item => item.value))];
  //   values.categories = [...new Set(values.categories)];
  // }
  history.push({
    pathname: location.pathname,
    query: values
  });
}

export function flowStatusToColor(code) {
  switch (code) {
    case 1:
      return 'blue';
    case 2:
      return 'yellow';
    case 3:
      return 'red';
    default:
      break;
  }
}

export function getNull(obj) {
  let newObj = { ...obj };
  Object.keys(newObj).forEach(k => newObj[k] = null);
  return newObj;
}

export async function validateForm(form) {
  try {
    return await form.validateFields();
  } catch (e) {
    //console.log(e);
  }
}

// 1-今天 2-本周 3-本月 4-今年 5-去年 6-7天内 7-30天内 8-1年内
export function radioValueToTimeRange(value) {
  switch (value) {
    case 1:
      return [moment().startOf('day'), moment().endOf('day')];
    case 2:
      return [moment().startOf('week'), moment().endOf('week')]
    case 3:
      return [moment().startOf('month'), moment().endOf('month')];
    case 4:
      return [moment().startOf('year'), moment().endOf('year')];
    case 5:
      return [moment().subtract(1, 'years').startOf('year'), moment().subtract(1, 'years').endOf('year')];
    case 6:
      return [moment().subtract(7, 'days'), moment()];
    case 7:
      return [moment().subtract(30, 'days'), moment()];
    case 8:
      return [moment().subtract(1, 'years'), moment()];
  }
}

export function initPagination() {
  const intl = useIntl();
  return {
    showQuickJumper: true,
    current: 1,
    pageSize: 15,
    showTotal: (total, range) => intl.formatMessage({id:'pagination.showTotal'}, {range0:range[0], range1:range[1], total:total}),
  }
}

export function getPagination(data, pagination) {
  return {
    ...pagination,
    current: data.number+1,
    pageSize: data.size,
    total: data.totalElements
  };
}

export function getTimeFormat() {
  let timeFormat = 'YYYY-MM-DD';
  if (getTimeEnable()) {
    timeFormat = 'YYYY-MM-DD HH:mm';
  }
  return timeFormat;
}

export function getTimeEnable() {
  let defaultBook = getDvaApp()._store.getState().session.defaultBook;
  if (defaultBook && defaultBook.timeEnable) return true;
  else return false;
}

export function getDescriptionEnable() {
  let defaultBook = getDvaApp()._store.getState().session.defaultBook;
  if (defaultBook && defaultBook.descriptionEnable) return true;
  else return false;
}

export function getImageEnable() {
  let defaultBook = getDvaApp()._store.getState().session.defaultBook;
  if (defaultBook && defaultBook.imageEnable) return true;
  else return false;
}

export function categoryTypeToCreateParam(type) {
  switch (type) {
    case 1:
      return { expenseable: true };
    case 2:
      return { incomeable: true };
    case 3:
      return { transferable: true };
  }
}

export function refreshFlow(data) {
  const dispatch = getDvaApp()._store.dispatch;
  if (history.location.pathname === '/expenses') {
    dispatch({ type: 'expenses/query', payload: history.location.query });
  }
  if (history.location.pathname === '/incomes') {
    dispatch({ type: 'incomes/query', payload: history.location.query });
  }
  if (history.location.pathname === '/transfers') {
    dispatch({ type: 'transfers/query', payload: history.location.query });
  }
  if (history.location.pathname === '/flows') {
    dispatch({ type: 'flows/query', payload: history.location.query });
  }
  if (history.location.pathname === '/audit') {
    dispatch({ type: 'audit/query', payload: history.location.query });
  }
  // if (history.location.pathname === '/accounts') {
  //   dispatch({ type: 'accounts/refresh' });
  // }
  // if (history.location.pathname === '/checking-accounts') {
  //   dispatch({ type: 'checkingAccounts/refresh', payload: data });
  // }
  // if (history.location.pathname === '/credit-accounts') {
  //   dispatch({ type: 'creditAccounts/refresh', payload: data });
  // }
  // if (history.location.pathname === '/debt-accounts') {
  //   dispatch({ type: 'debtAccounts/refresh', payload: data });
  // }
  // if (history.location.pathname === '/asset-accounts') {
  //   dispatch({ type: 'assetAccounts/refresh', payload: data });
  // }
}

export function searchTreeArray(treeArray, value, key = 'id', reverse = true) {
  for (var i = 0; i < treeArray.length; i++) {
    const stack = [ treeArray[i] ];
    while (stack.length) {
      const node = stack[reverse ? 'pop' : 'shift']();
      if (node[key] === value) return node;
      node.children && stack.push(...node.children);
    }
  }
  return null;
}

