import 'dart:convert';
import '/commons/commons.dart';
import '/currency/currency.dart';

class CurrencyRepository {

  Future<List<Currency>> getAll() async {
    String response = await HttpClient().get('currency/all');
    return (json.decode(response)['data']).map<Currency>((i) => Currency.fromJson(i)).toList();
  }

}