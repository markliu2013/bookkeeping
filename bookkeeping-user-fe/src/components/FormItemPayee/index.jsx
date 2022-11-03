import {useState} from "react";
import {Divider, Form, Input, message, Select} from 'antd';
import {useDispatch} from "umi";
import {PlusOutlined} from "@ant-design/icons";
import {categoryTypeToCreateParam} from "@/utils/util";
import {create as createPayee} from "@/services/payee";
import t from "@/utils/translate";

export default (props) => {

  const dispatch = useDispatch();
  const { form, payees, setPayees, type } = props;

  const [addPayeeName, setAddPayeeName] = useState();
  function addPayeeInputChange(event) {
    setAddPayeeName(event.target.value)
  }
  const [addPayeeLoading, setAddPayeeLoading] = useState(false);
  async function addPayeeHandler() {
    if (addPayeeLoading) return;
    if (!addPayeeName) return;
    setAddPayeeLoading(true);
    const response = await createPayee({...{ name: addPayeeName }, ...categoryTypeToCreateParam(type)});
    if (response && response.success) {
      setPayees([...payees, {value: response.data.id, label: response.data.name}]);
      setAddPayeeName('');
      form.setFieldsValue({payeeId: response.data.id});
      dispatch({ type: 'payee/refresh', payload: { ...response.data } });
    }
    setAddPayeeLoading(false);
  }

  return (
    <Form.Item label={t('flow.payee')} name="payeeId">
      <Select
        showSearch={true}
        allowClear={true}
        filterOption={true}
        optionFilterProp={"label"}
        options={payees}
        dropdownRender={menu => (
          <div>
            {menu}
            <>
              <Divider style={{ margin: '4px 0' }} />
              <div style={{ display: 'flex', flexWrap: 'nowrap', padding: 4 }}>
                <Input style={{ flex: 'auto' }} value={addPayeeName} onChange={addPayeeInputChange} />
                <a style={{ flex: 'none', padding: '4px', display: 'block', cursor: 'pointer' }} onClick={addPayeeHandler}>
                  <PlusOutlined /> {t('add')}
                </a>
              </div>
            </>
          </div>
        )}
      >
      </Select>
    </Form.Item>
  );

};
