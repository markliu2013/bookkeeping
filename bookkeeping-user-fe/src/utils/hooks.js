import { useEffect, useState, useRef } from 'react';
import {useIntl, useSelector} from 'umi';
import { message } from 'antd';

export function useFocus() {
  const htmlElRef = useRef(null);
  const setFocus = () => {htmlElRef.current &&  htmlElRef.current.focus()};
  return [ htmlElRef,  setFocus ];
}

export function usePaginationAndData(queryResponse) {

  const intl = useIntl();

  const [dataAndPagination, setDataAndPagination] = useState({
    data: [],
    pagination: {
      showQuickJumper: true,
      current: 1,
      pageSize: 10,
      showTotal: (total, range) => intl.formatMessage({id:'pagination.showTotal'}, {range0:range[0], range1:range[1], total:total}),
    }
  });
  useEffect(() => {
    if (queryResponse && queryResponse.success) {
      setDataAndPagination({
        data: queryResponse.data.content,
        pagination: {
          ...dataAndPagination.pagination,
          current: queryResponse.data.number+1,
          pageSize: queryResponse.data.size,
          total: queryResponse.data.totalElements
        }
      });
    }
  }, [queryResponse]);
  return [dataAndPagination, setDataAndPagination]
}

export function useResultPaginationAndData(queryResponse) {

  const intl = useIntl();

  const [dataAndPagination, setDataAndPagination] = useState({
    data: [],
    pagination: {
      showQuickJumper: true,
      current: 1,
      pageSize: 10,
      showTotal: (total, range) => intl.formatMessage({id:'pagination.showTotal'}, {range0:range[0], range1:range[1], total:total}),
    }
  });
  useEffect(() => {
    if (queryResponse && queryResponse.success) {
      setDataAndPagination({
        data: queryResponse.data.result.content,
        pagination: {
          ...dataAndPagination.pagination,
          current: queryResponse.data.result.number+1,
          pageSize: queryResponse.data.result.size,
          total: queryResponse.data.result.totalElements
        }
      });
    }
  }, [queryResponse]);
  return [dataAndPagination, setDataAndPagination]
}

export function useResponseData(queryResponse) {
  const [responseData, setResponseData] = useState([]);
  useEffect(() => {
    if (queryResponse && queryResponse.success) {
      setResponseData(queryResponse.data);
    }
  }, [queryResponse]);
  return [responseData, setResponseData];
}

export function useResponseSelectData(queryResponse) {
  const [responseSelectData, setResponseSelectData] = useState([]);
  useEffect(() => {
    if (queryResponse && queryResponse.success) {
      setResponseSelectData(queryResponse.data.map(item => {
        return {
          value: item.id,
          title: item.name,
          label: item.name
        }
      }));
    }
  }, [queryResponse]);
  return [responseSelectData, setResponseSelectData];
}

export function useCurrencyResponseSelectData(queryResponse) {
  const [responseSelectData, setResponseSelectData] = useState([]);
  useEffect(() => {
    if (queryResponse && queryResponse.success) {
      setResponseSelectData(queryResponse.data.map(item => {
        return {
          value: item.code,
          title: item.code,
          label: item.code
        }
      }));
    }
  }, [queryResponse]);
  return [responseSelectData, setResponseSelectData];
}

export function useCategoryTreeSelectData(categoriesResponse) {
  const [categories, setCategories] = useState([]);
  useEffect(() => {
    if (categoriesResponse && categoriesResponse.success) {
      setCategories(categoriesResponse.data.map(item => {
        return {
          id: item.id,
          pId: item.parentId,
          value: item.id,
          title: item.name
        }
      }));
    }
  }, [categoriesResponse]);
  return [categories, setCategories];
}

export function useImageEnable() {
  const [enable, setEnable] = useState(false);
  const { defaultBook } = useSelector(state => state.session);
  useEffect(() => {
    if (defaultBook && defaultBook.imageEnable) {
      setEnable(true);
    } else {
      setEnable(false);
    }
  }, [defaultBook]);
  return enable;
}

export function useDescriptionEnable() {
  const [enable, setEnable] = useState(false);
  const { defaultBook } = useSelector(state => state.session);
  useEffect(() => {
    if (defaultBook && defaultBook.descriptionEnable) {
      setEnable(true);
    } else {
      setEnable(false);
    }
  }, [defaultBook]);
  return enable;
}

export function useTimeFormat() {
  const [format, setFormat] = useState('YYYY-MM-DD');
  const { defaultBook } = useSelector(state => state.session);
  useEffect(() => {
    if (defaultBook && defaultBook.timeEnable) {
      setFormat('YYYY-MM-DD HH:mm');
    } else {
      setFormat('YYYY-MM-DD');
    }
  }, [defaultBook]);
  return format;
}
