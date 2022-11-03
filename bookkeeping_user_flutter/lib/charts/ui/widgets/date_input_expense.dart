import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '/components/components.dart';
import '/charts/charts.dart';

class DateInputExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportExpenseCategoryBloc, ReportExpenseCategoryState>(
      buildWhen: (previous, current) => previous.request.minTime != current.request.minTime || previous.request.maxTime != current.request.maxTime,
      builder: (context, state) {
        return Row(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final PickerDateRange? range =
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DateRangePicker(
                            PickerDateRange(DateTime.fromMillisecondsSinceEpoch(state.request.minTime!), DateTime.fromMillisecondsSinceEpoch(state.request.maxTime!))
                        );
                      }
                  );
                  if (range != null) {
                    BlocProvider.of<ReportExpenseCategoryBloc>(context).add(ReportExpenseCategoryMinTimeChanged(range.startDate!.millisecondsSinceEpoch));
                    BlocProvider.of<ReportExpenseCategoryBloc>(context).add(ReportExpenseCategoryMaxTimeChanged(range.endDate!.millisecondsSinceEpoch));
                  }
                },
                child: Text('选择日期范围')
            ),
            SizedBox(width: 10),
            Text(
                DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.request.minTime!))+
                    ' - '+
                    DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.request.maxTime!))
            )
          ],
        );
      }
    );
  }
}
