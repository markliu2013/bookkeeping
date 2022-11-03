import 'dart:convert';
import 'package:intl/intl.dart';

String removeDecimalZero(num n) {
  RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
  return n.toString().replaceAll(regex, "");
}

String boolToString(bool val) {
  if (val) return '是';
  else return '否';
}

String dateFormat(int? timestamp) {
  if (timestamp == null) return '';
  return DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
}

bool parseResponse(String response) {
  return json.decode(response)['success'];
}