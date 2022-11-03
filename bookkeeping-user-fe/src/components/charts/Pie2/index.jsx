import { useEffect, useRef, useState } from "react";
import { Empty, Spin, Divider } from "antd";
import { Chart, Geom, Coord, Tooltip, Label, Guide } from "bizcharts";
import { DataView } from '@antv/data-set';
import t from '@/utils/translate';
import styles from './index.less';


export default (props) => {

  const { data, loading = false } = props;

  const dv = new DataView();
  dv.source(data).transform({
    type: 'percent',
    field: 'y',
    dimension: 'x',
    as: 'percent',
  });

  const tooltipFormat = [
    'x*y',
    (x, y) => ({
      name: x,
      value: y,
    }),
  ];

  const legendClickHandler = (item, i) => {
    const newItem = item;
    newItem.checked = !newItem.checked;
    const newLegendData = [...legendData];
    newLegendData[i] = newItem;
    const filteredLegendData = newLegendData.filter((l) => l.checked).map((l) => l.x);
    if (chartRef.current) {
      chartRef.current.filter('x', (val) => filteredLegendData.indexOf(`${val}`) > -1);
    }
    setLegendData(newLegendData);
  };

  const chartRef = useRef(null);
  const getG2Instance = (chart) => {
    chartRef.current = chart;
  };
  useEffect(() => {
    getLegendData();
  }, [data]);
  const [legendData, setLegendData] = useState([]);
  const getLegendData = () => {
    if (!chartRef || !chartRef.current) return;
    const geom = chartRef.current.getAllGeoms()[0]; // 获取所有的图形
    if (!geom) return;
    const items = geom.get('dataArray') || []; // 获取图形对应的
    const legendData = items.map((item) => {
      /* eslint no-underscore-dangle:0 */
      const origin = item[0]._origin;
      origin.color = item[0].color;
      origin.checked = true;
      return origin;
    });
    setLegendData(legendData);
  };

  const totalMessage = t('gross.amount');
  const total = data.reduce((pre, now) => now.y + pre, 0).toFixed(2);
  return (
    <Spin spinning={loading} size="large">
      <div className={styles['pie']}>
      { data && data.length > 0 && total > 0 ?
        (
          <>
            <Chart className={styles['chart']} height={450} data={dv} forceFit padding={[10, 120, 10, 120]} onGetG2Instance={getG2Instance}>
              <Coord type="theta" radius={0.9} innerRadius={0.75} />
              <Tooltip showTitle={false} />
              <Geom type="intervalStack" position="percent" color="x" tooltip={ tooltipFormat }>
                <Label content="percent" formatter={(val, x) => `${x.point.x}: ${(val * 100).toFixed(2)}%`} />
              </Geom>
              <Guide>
                <Guide.Html
                  position={["50%", "50%"]}
                  html={`<div style="color:#8c8c8c;font-size:1.5rem;text-align: center;width: 10em;">${totalMessage}<br><span style="color:rgba(0,0,0,0.85);font-size:2.4rem;">${total}</span></div>`}
                  alignX="middle"
                  alignY="middle"
                />
              </Guide>
            </Chart>
            <ul className={styles['legend']}>
              {legendData.map((item, i) => (
              <li key={item.x} onClick={() => legendClickHandler(item, i)}>
                <span className={styles.dot} style={{backgroundColor: !item.checked ? '#aaa' : item.color}} />
                <span className={styles.legendTitle}>{item.x}</span>
                <Divider type="vertical" />
                <span className={styles.percent}>{`${(Number.isNaN(item.percent) ? 0 : item.percent * 100).toFixed(2)}%`}</span>
                <span>&nbsp;</span>
                <span className={styles.value}>{item.y}</span>
              </li>
              ))}
            </ul>
          </>
        ) :
        (<Empty style={{ paddingTop:50, width:"100%" }} />)
      }
      </div>
    </Spin>
  )
}
