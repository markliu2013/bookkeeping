import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '/components/components.dart';
import '/items/items.dart';

class DateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemFormBloc, ItemFormState>(
      buildWhen: (previous, current) => previous.startDate != current.startDate || previous.endDate != current.endDate,
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
                          PickerDateRange(DateTime.fromMillisecondsSinceEpoch(state.startDate!), DateTime.fromMillisecondsSinceEpoch(state.endDate!))
                        );
                      }
                  );
                  if (range != null) {
                    BlocProvider.of<ItemFormBloc>(context).add(ItemFormStartDateChanged(range.startDate!.millisecondsSinceEpoch));
                    BlocProvider.of<ItemFormBloc>(context).add(ItemFormEndDateChanged(range.endDate!.millisecondsSinceEpoch));
                  }
                },
                child: Text('选择日期范围')
            ),
            SizedBox(width: 10),
            Text(
                DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.startDate!))+
                ' - '+
                DateFormat('yyyy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(state.endDate!))
            ),
          ],
        );
      }
    );
  }
}
