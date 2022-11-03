import 'dart:convert';

import 'models/category.dart';
import '/commons/commons.dart';
import '/categories/categories.dart';

class CategoryRepository {

  List<Category> _responseToList(String response) {
    return (json.decode(response)['data']).map<Category>((i) => Category.fromJson(i)).toList();
  }

  Future<List<Category>> getExpenseable() async {
    String response = await HttpClient().get('expense-categories/enable');
    return _responseToList(response);
  }

  Future<List<Category>> getIncomeable() async {
    String response = await HttpClient().get('income-categories/enable');
    return _responseToList(response);
  }

  Future<List<CategoryTree>> queryExpense() async {
    String response = await HttpClient().get('expense-categories');
    return (json.decode(response)['data']).map<CategoryTree>((i) => CategoryTree.fromJson(i)).toList();
  }

  Future<List<CategoryTree>> queryIncome() async {
    String response = await HttpClient().get('income-categories');
    return (json.decode(response)['data']).map<CategoryTree>((i) => CategoryTree.fromJson(i)).toList();
  }

  Future<Category> get(int id) async {
    String response = await HttpClient().get('categories/$id');
    return Category.fromJson(json.decode(response)['data']);
  }

  Future<bool> toggle(String id) async {
    String response = await HttpClient().put('categories/$id/toggle');
    return parseResponse(response);
  }

  Future<bool> delete(String id) async {
    String response = await HttpClient().delete('categories/$id');
    return parseResponse(response);
  }

  Future<bool> add(int type, CategoryFormRequest request) async {
    String response = '';
    switch(type) {
      case 1:
        response = await HttpClient().post('expense-categories', data: request.toJson());
        return parseResponse(response);
      case 2:
        response = await HttpClient().post('income-categories', data: request.toJson());
        return parseResponse(response);
      default:
        throw('type error');
    }
  }

  Future<bool> update(int type, int id, CategoryFormRequest request) async {
    String response = '';
    switch(type) {
      case 1:
        response = await HttpClient().put('expense-categories/$id', data: request.toJson());
        return parseResponse(response);
      case 2:
        response = await HttpClient().put('income-categories/$id', data: request.toJson());
        return parseResponse(response);
      default:
        throw('type error');
    }
  }

}