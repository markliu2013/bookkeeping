import 'dart:convert';

import '/payees/payees.dart';
import '/commons/commons.dart';

class PayeeRepository {

  List<Payee> _responseToList(String response) {
    return (json.decode(response)['data']).map<Payee>((i) => Payee.fromJson(i)).toList();
  }

  Payee _responsePayee(String response) {
    return Payee.fromJson(json.decode(response)['data']);
  }

  Future<List<Payee>> getExpenseable() async {
    String response = await HttpClient().get('payees/expenseable');
    return _responseToList(response);
  }

  Future<List<Payee>> getIncomeable() async {
    String response = await HttpClient().get('payees/incomeable');
    return _responseToList(response);
  }

  Future<List<Payee>> getEnable() async {
    String response = await HttpClient().get('payees/enable');
    return _responseToList(response);
  }

  Future<List<Payee>> query(PayeeQueryRequest request) async {
    String response = await HttpClient().get('payees', params: request.toJson());
    return (json.decode(response)['data']['content']).map<Payee>((i) => Payee.fromJson(i)).toList();
  }

  Future<Payee> get(int id) async {
    return _responsePayee(await HttpClient().get('payees/$id'));
  }

  Future<bool> delete(String id) async {
    String response = await HttpClient().delete('payees/$id');
    return parseResponse(response);
  }

  Future<bool> toggle(String id) async {
    String response = await HttpClient().put('payees/$id/toggle');
    return parseResponse(response);
  }

  Future<bool> add(PayeeFormRequest request) async {
    String response = await HttpClient().post('payees', data: request.toJson());
    return parseResponse(response);
  }

  Future<bool> update(int id, PayeeFormRequest request) async {
    String response = await HttpClient().put('payees/$id', data: request.toJson());
    return parseResponse(response);
  }

}