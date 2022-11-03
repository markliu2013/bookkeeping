import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/charts/charts.dart';
import '/components/components.dart';
import '/commons/commons.dart';

class ExpenseCategory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
        child: BlocBuilder<ReportExpenseCategoryBloc, ReportExpenseCategoryState>(
          builder: (context, state) {
            if (state.status == LoadDataStatus.success) {
              return Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                      DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.request.minTime!))+
                          ' - '+
                          DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.request.maxTime!)),
                    style: theme.textTheme.headline6,
                  ),
                  SfCircularChart(
                    title: ChartTitle(text: '支出分类'),
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
                ],
              );
            }
            return Container(
              height: 200,
              child: const PageLoading(),
            );
          },
        )
    );
  }

}