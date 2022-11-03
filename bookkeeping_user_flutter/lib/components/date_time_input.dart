import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeInput extends StatelessWidget {

  final int? initialTime;
  final Function(DateTime) onDateChange;
  final Function(TimeOfDay) onTimeChange;

  DateTimeInput({
    this.initialTime,
    required this.onDateChange,
    required this.onTimeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.fromMillisecondsSinceEpoch(initialTime ?? DateTime.now().millisecondsSinceEpoch),
              firstDate: DateTime(2015),
              lastDate: DateTime(2025)
            ).then((value) => {
              if (value != null) onDateChange(value)
            });
          },
          child: Text('选择日期')
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then((value) => {
              if (value != null) onTimeChange(value)
            });
          },
          child: Text('选择时间')
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(DateFormat('yyyy-MM-dd kk:mm').format(DateTime.fromMillisecondsSinceEpoch(initialTime ?? DateTime.now().millisecondsSinceEpoch))),
        )
      ],
    );
  }

}