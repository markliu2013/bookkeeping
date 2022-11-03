import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '/charts/charts.dart';

Widget buildFormItem(String label, Widget field, BuildContext context) {
  return
    Container(
      // height: 45,
      child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyText1),
            SizedBox(width: 10),
            Expanded(child: field)
          ]
        )
  );
}

List<S2Choice<String>> modelToChoice(models) {
  return S2Choice.listFrom<String, dynamic>(
    source: models,
    value: (index, item) => item.id.toString(),
    title: (index, item) => item.name,
  );
}

List<S2Choice<String>> modelToChoiceCode(models) {
  return S2Choice.listFrom<String, dynamic>(
    source: models,
    value: (index, item) => item.code,
    title: (index, item) => item.code,
  );
}

Future<bool> confirm(
    BuildContext context, {
      Widget? title,
      Widget? content,
      Widget? textOK,
      Widget? textCancel,
    }) async {
  final bool? isConfirm = await showDialog<bool>(
    context: context,
    builder: (_) => WillPopScope(
      child: AlertDialog(
        title: title,
        content: (content != null) ? content : Text('Are you sure continue?'),
        actions: <Widget>[
          TextButton(
            child: textCancel != null ? textCancel : Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: textOK != null ? textOK : Text('OK'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
    ),
  );

  return (isConfirm != null) ? isConfirm : false;
}

class Message {

  static success(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static error(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}

void fullDialog(BuildContext context, Widget widget) {
  Navigator.of(context, rootNavigator: false).push( // ensures fullscreen
      CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => widget
      )
  );
}

List<DoughnutSeries<XY, String>> getDefaultDoughnutSeries(xys) {
  return [
    DoughnutSeries<XY, String>(
      radius: '80%',
      innerRadius: '70%',
      dataSource: xys,
      xValueMapper: (XY data, _) => data.x,
      yValueMapper: (XY data, _) => data.y,
      dataLabelMapper: (XY data, _) => data.x + ": " + data.percent.toString() + "%",
      dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: const TextStyle(fontSize: 6),
          labelPosition: ChartDataLabelPosition.outside
      ),
      legendIconType: LegendIconType.circle,
    )
  ];
}