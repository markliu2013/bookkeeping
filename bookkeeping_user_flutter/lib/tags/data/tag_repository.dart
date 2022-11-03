import 'dart:convert';

import '/commons/commons.dart';
import '/tags/tags.dart';

class TagRepository {

  List<Tag> _responseToList(String response) {
    return (json.decode(response)['data']).map<Tag>((i) => Tag.fromJson(i)).toList();
  }

  Future<List<Tag>> getExpenseable() async {
    String response = await HttpClient().get('tags/expenseable');
    return _responseToList(response);
  }

  Future<List<Tag>> getIncomeable() async {
    String response = await HttpClient().get('tags/incomeable');
    return _responseToList(response);
  }

  Future<List<Tag>> getTransferable() async {
    String response = await HttpClient().get('tags/transferable');
    return _responseToList(response);
  }

  Future<List<Tag>> getEnable() async {
    String response = await HttpClient().get('tags/enable');
    return _responseToList(response);
  }

  Future<Tag> get(int id) async {
    String response = await HttpClient().get('tags/$id');
    return Tag.fromJson(json.decode(response)['data']);
  }

  Future<List<TagTree>> query() async {
    String response = await HttpClient().get('tags');
    return (json.decode(response)['data']).map<TagTree>((i) => TagTree.fromJson(i)).toList();
  }

  Future<bool> toggle(String id) async {
    String response = await HttpClient().put('tags/$id/toggle');
    return parseResponse(response);
  }

  Future<bool> delete(String id) async {
    String response = await HttpClient().delete('tags/$id');
    return parseResponse(response);
  }

  Future<bool> add(TagFormRequest request) async {
    String response = await HttpClient().post('tags', data: request.toJson());
    return parseResponse(response);
  }

  Future<bool> update(int id, TagFormRequest request) async {
    String response = await HttpClient().put('tags/$id', data: request.toJson());
    return parseResponse(response);
  }

}