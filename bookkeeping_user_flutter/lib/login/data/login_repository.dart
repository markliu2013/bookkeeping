import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '/login/login.dart';
import '/commons/commons.dart';

class LogInFailure implements Exception { }

class LoginRepository {

  Future<String> logIn({
    required String username,
    required String password
  }) async {
    String response = await HttpClient().post('signin', data: {'userName': username, 'password': password});
    var responseDecoded = json.decode(response);
    if (responseDecoded['success']) {
      return responseDecoded['data']['token'];
    } else {
      throw LogInFailure();
    }
  }

  Future<Session> getSession() async {
    String response = await HttpClient().get('session');
    // TODO response 可能失败
    return Session.fromJson(json.decode(response)['data']);
  }

  Future<bool> saveToken(String token) async {
    session["userToken"] = token;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('User-Token', token);
  }

  Future<bool> saveApiUrl(String url) async {
    session["apiUrl"] = url;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    HttpClient().init();
    return prefs.setString('Api-Url', url);
  }

  Future<bool> deleteToken() async {
    session["userToken"] = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('User-Token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userToken = prefs.getString('User-Token') ?? '';
    session['userToken'] = userToken;
    return userToken;
  }

  Future<String> getApiUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String apiUrl = prefs.getString('Api-Url') ?? '';
    session['apiUrl'] = apiUrl;
    return apiUrl;
  }

}