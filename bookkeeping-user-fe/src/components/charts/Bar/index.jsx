import { Axis, Chart, Geom, Tooltip } from "bizcharts";
import {Empty, Spin} from "antd";

export default (props) => {

  const { data, loading = false } = props;

  return (
    <Spin spinning={loading} size="large">
      {data && data.length > 0 ?
        <Chart height={400} data={data} forceFit padding={[50, 30, 20, 40]}>
          <Axis name="x"/>
          <Axis name="y"/>
          <Geom type="interval" position="x*y"/>
          <Tooltip
            showTitle={false}
            itemTpl={`<li data-index={index} style="padding-bottom:15px">{value}</li>`}
          />
        </Chart> :
        <Empty style={{paddingTop: 50, width: "100%"}}/>
      }
    </Spin>
  )
}
