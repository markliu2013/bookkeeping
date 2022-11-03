import 'dart:convert';

import '/commons/commons.dart';
import '/items/items.dart';

class ItemRepository {

  Future<bool> save(ItemAddRequest request) async {
    String response = await HttpClient().post('items', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> update(int id, ItemAddRequest request) async {
    String response = await HttpClient().put('items/$id', data: request.toJson());
    return parseResponse(response);
  }

  Future<List<Item>> query(ItemQueryRequest request) async {
    String response = await HttpClient().get('items', params: request.toJson());
    return json.decode(response)['data']['content'].map<Item>((i) => Item.fromJson(i)).toList();
  }

  Future<bool> delete(String id) async {
    String response = await HttpClient().delete('items/$id');
    return parseResponse(response);
  }

}