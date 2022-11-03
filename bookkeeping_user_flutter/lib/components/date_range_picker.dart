import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePicker extends StatefulWidget {
  final dynamic range;
  const DateRangePicker(this.range);

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {

  dynamic _controller;
  dynamic _range;

  @override
  void initState() {
    _range = widget.range;
    _controller = DateRangePickerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Widget selectedDateWidget = Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: _range == null || _range.startDate == null || _range.endDate == null || _range.startDate == _range.endDate ?
          Text(
            DateFormat('yyyy-MM-dd').format(_range.startDate ?? _range.endDate),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
            )
          ) :
        Row(
          children: [
            Expanded(
                flex: 5,
                child: Text(
                  DateFormat('yyyy-MM-dd').format(
                    _range.startDate.isAfter(_range.endDate) ==
                        true
                        ? _range.endDate
                        : _range.startDate
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
            ),
            const VerticalDivider(
              thickness: 1,
            ),
            Expanded(
                flex: 5,
                child: Text(
                  DateFormat('yyyy-MM-dd').format(
                    _range.startDate.isAfter(_range.endDate) ==
                        true
                        ? _range.startDate
                        : _range.endDate
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
            )
          ],
        ),
      ),
    );

    _controller.selectedRange = _range;

    Widget pickerWidget = SfDateRangePicker(
      controller: _controller,
      selectionMode: DateRangePickerSelectionMode.range,
      showNavigationArrow: true,
      showActionButtons: true,
      confirmText: '确定',
      cancelText: '取消',
      onCancel: () => Navigator.pop(context, null),
      headerStyle: DateRangePickerHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: TextStyle(color: Colors.black, fontSize: 15)
      ),
      onSubmit: (Object? value) {
        Navigator.pop(context, _range);
      },
      onSelectionChanged: (DateRangePickerSelectionChangedArgs details) {
        setState(() {
          _range = details.value;
        });
      },
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Container(
        width: 300,
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            selectedDateWidget,
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: pickerWidget
              )
            )
          ],
        ),
      )
    );
  }
}