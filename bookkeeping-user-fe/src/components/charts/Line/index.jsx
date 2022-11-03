import {Axis, Chart, Geom, Legend, Tooltip} from "bizcharts";
import {Spin} from "antd";

export default (props) => {

  const { data, scale, height, padding, loading = false } = props;

  return (
    <Spin spinning={loading} size="large">
      <Chart data={data} scale={scale} forceFit height={height} padding={padding}>
        <Legend />
        <Axis name="x1" label={{rotate: 30, offset: 20}} />
        <Axis name="y" />
        <Tooltip crosshairs={{ type: "y" }} />
        <Geom type="line" position="x1*y" size={2} color="x2" />
        <Geom type="point" position="x1*y" size={4} shape="circle" color="x2" style={{ stroke: "#fff", lineWidth: 1 }} />
      </Chart>
    </Spin>
  )
}
