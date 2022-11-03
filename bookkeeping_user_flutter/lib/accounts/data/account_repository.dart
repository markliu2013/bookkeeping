import 'dart:convert';
import '/commons/commons.dart';
import '/accounts/accounts.dart';

class AccountRepository {

  List<Account> _responseToList(String response) {
    return (json.decode(response)['data']).map<Account>((i) => Account.fromJson(i)).toList();
  }

  Account _responseAccount(String response) {
    return Account.fromJson(json.decode(response)['data']);
  }

  List<Account> _responseToList2(String response) {
    return (json.decode(response)['data']['content']).map<Account>((i) => Account.fromJson(i)).toList();
  }

  Future<List<Account>> getExpenseable() async {
    String response = await HttpClient().get('accounts/expenseable');
    return _responseToList(response);
  }

  Future<List<Account>> getIncomeable() async {
    String response = await HttpClient().get('accounts/incomeable');
    return _responseToList(response);
  }

  Future<List<Account>> getTransferFromAble() async {
    String response = await HttpClient().get('accounts/transfer-from-able');
    return _responseToList(response);
  }

  Future<List<Account>> getTransferToAble() async {
    String response = await HttpClient().get('accounts/transfer-to-able');
    return _responseToList(response);
  }

  Future<List<Account>> getEnable() async {
    String response = await HttpClient().get('accounts/enable');
    return _responseToList(response);
  }

  Future<List<Account>> query(AccountQueryRequest request) async {
    switch(request.type) {
      case 1:
        return _responseToList2(await HttpClient().get('checking-accounts', params: request.toJson()));
      case 2:
        return _responseToList2(await HttpClient().get('credit-accounts', params: request.toJson()));
      case 3:
        return _responseToList2(await HttpClient().get('debt-accounts', params: request.toJson()));
      case 4:
        return _responseToList2(await HttpClient().get('asset-accounts', params: request.toJson()));
      default:
        throw('type error');
    }
  }

  Future<Account> get(int id) async {
    return _responseAccount(await HttpClient().get('accounts/$id'));
  }

  Future<bool> delete(String id) async {
    String response = await HttpClient().delete('accounts/$id');
    return parseResponse(response);
  }

  Future<bool> toggle(String id) async {
    String response = await HttpClient().put('accounts/$id/toggle');
    return parseResponse(response);
  }

  Future<bool> add(int type, AccountFormRequest request) async {
    String response = '';
    switch(type) {
      case 1:
        response = await HttpClient().post('checking-accounts', data: request.toJson());
        return parseResponse(response);
      case 2:
        response = await HttpClient().post('credit-accounts', data: request.toJson());
        return parseResponse(response);
      case 3:
        response = await HttpClient().post('debt-accounts', data: request.toJson());
        return parseResponse(response);
      case 4:
        response = await HttpClient().post('asset-accounts', data: request.toJson());
        return parseResponse(response);
      default:
        throw('type error');
    }
  }

  Future<bool> update(int id, AccountFormRequest request) async {
    String response = await HttpClient().put('accounts/$id', data: request.toJson());
    return parseResponse(response);
  }

  Future<bool> adjustBalance(int id, AdjustBalanceRequest request) async {
    String response = await HttpClient().post('accounts/$id/adjust-balance', data: request.toJson());
    return parseResponse(response);
  }

  Future<bool> updateAdjustBalance(int id, AdjustBalanceRequest request) async {
    String response = await HttpClient().put('adjust-balances/$id', data: request.toJson());
    return parseResponse(response);
  }

}