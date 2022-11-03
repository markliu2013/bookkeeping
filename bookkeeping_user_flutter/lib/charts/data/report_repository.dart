import 'dart:convert';
import '/commons/commons.dart';
import '/charts/charts.dart';

class ReportRepository {

  List<XY> _responseToList(String response) {
    return (json.decode(response)['data']).map<XY>((i) => XY.fromJson(i)).toList();
  }

  Future<List<XY>> getAsset() async {
    String response = await HttpClient().get('reports/asset');
    return _responseToList(response);
  }

  Future<List<XY>> getDebt() async {
    String response = await HttpClient().get('reports/debt');
    return _responseToList(response);
  }

  Future<List<XY>> queryExpenseCategory(CategoryQueryRequest request) async {
    String response = await HttpClient().get('reports/expense-category', params: request.toJson());
    return _responseToList(response);
  }

  Future<List<XY>> queryIncomeCategory(CategoryQueryRequest request) async {
    String response = await HttpClient().get('reports/income-category', params: request.toJson());
    return _responseToList(response);
  }

}