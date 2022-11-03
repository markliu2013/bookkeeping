import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/charts/charts.dart';
import '/components/components.dart';
import '/commons/commons.dart';

class AssetSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ReportAssetBloc, ReportAssetState>(
              builder: (context, state) {
                if (state is ReportAssetStateLoadSuccess) {
                  return Column(
                    children: [
                      SfCircularChart(
                        title: ChartTitle(text: '资产分类'),
                        legend: Legend(isVisible: false),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: getDefaultDoughnutSeries(state.xys),
                        annotations: [
                          CircularChartAnnotation(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('总金额', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                Text(removeDecimalZero(state.total), style: TextStyle(color: Colors.black, fontSize: 18))
                              ],
                            )
                          )
                        ],
                      ),
                      Divider(),
                      CircularLegend(xys: state.xys),
                      Divider(),
                    ],
                  );
                }
                return Container(
                  height: 200,
                  child: const PageLoading(),
                );
              },
            ),
          ],
        )
    );
  }

}