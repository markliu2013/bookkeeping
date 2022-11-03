import 'dart:convert';
import '/commons/commons.dart';
import '/books/books.dart';

class BookRepository {

  List<Book> _responseToList(String response) {
    return (json.decode(response)['data']['content']).map<Book>((i) => Book.fromJson(i)).toList();
  }

  Book _responseBook(String response) {
    return Book.fromJson(json.decode(response)['data']);
  }

  Future<List<Book>> query(BookQueryRequest request) async {
    return _responseToList(await HttpClient().get('books', params: request.toJson()));
  }

  Future<Book> get(int id) async {
    return _responseBook(await HttpClient().get('accounts/$id'));
  }

  Future<bool> setDefault(String id) async {
    String response = await HttpClient().put('setDefaultBook/$id');
    return parseResponse(response);
  }

}