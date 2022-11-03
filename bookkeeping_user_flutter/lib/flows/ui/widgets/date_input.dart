import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '/components/components.dart';
import '/flows/flows.dart';

class DateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlowsBloc, FlowsState>(
      buildWhen: (previous, current) => previous.request.minTime != current.request.minTime || previous.request.maxTime != current.request.maxTime,
      builder: (context, state) {
        String dateText = '';
        DateTime? startDate;
        DateTime? endDate;
        if (state.request.minTime != null) {
          dateText = DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.request.minTime!));
          dateText = dateText + ' - ';
          startDate = DateTime.fromMillisecondsSinceEpoch(state.request.minTime!);
        }
        if (state.request.maxTime != null) {
          if (state.request.minTime == null) {
            dateText = dateText + ' - ';
          } else {
            dateText = dateText + DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.request.maxTime!));
          }
          endDate = DateTime.fromMillisecondsSinceEpoch(state.request.maxTime!);
        }
        return Row(
          children: [
            SizedBox(width: 15),
            ElevatedButton(
                onPressed: () async {
                  final PickerDateRange? range =
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DateRangePicker(PickerDateRange(startDate, endDate));
                    }
                  );
                  if (range != null) {
                    BlocProvider.of<FlowsBloc>(context).add(FlowsFilterMinTimeChanged(range.startDate!.millisecondsSinceEpoch));
                    BlocProvider.of<FlowsBloc>(context).add(FlowsFilterMaxTimeChanged(range.endDate!.millisecondsSinceEpoch));
                  }
                },
                child: Text('选择日期范围')
            ),
            SizedBox(width: 10),
            Text(dateText),
            SizedBox(width: 15),
          ],
        );
      }
    );
  }
}
