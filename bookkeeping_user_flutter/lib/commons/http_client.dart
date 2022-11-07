import 'package:dio/dio.dart';
import '/commons/commons.dart';

class HttpClient {

  // 单例模式
  static final HttpClient _instance = HttpClient._internal();
  factory HttpClient() => _instance;
  HttpClient._internal() {
    init();
  }

  late Dio _dio;
  init(){
    print('init');
    print(session['apiUrl']);
    BaseOptions baseOptions = BaseOptions(
      // baseUrl: 'http://127.0.0.1:9092/api/v1/',
      baseUrl: session['apiUrl'],
      contentType: 'application/json',
        // responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000
    );
    _dio = Dio(baseOptions);
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(ExceptionInterceptor());
  }

  Future<String> get(String uri, {Map<String, dynamic>? params}) async {
    var response = await _dio.get(uri, queryParameters: params);
    return response.toString();
  }

  Future<String> post(String uri, {data}) async {
    var response = await _dio.post(uri, data: data);
    return response.toString();
  }

  Future<String> delete(String uri) async {
    var response = await _dio.delete(uri);
    return response.toString();
  }

  Future<String> put(String uri, {data}) async {
    var response = await _dio.put(uri, data: data);
    return response.toString();
  }

  Future<String> upload(data) async {
    var response = await _dio.post('http://upload-z2.qiniup.com', data: FormData.fromMap(data));
    return response.toString();
  }

}

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (session["userToken"] != null) {
      options.headers['User-Token'] = session["userToken"];
    }
    super.onRequest(options, handler);
  }
}

// 全局错误处理
class ExceptionInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (!response.data['success']) {
      if (response.data['errorCode'] == 8 || response.data['errorCode'] == 10) {
        Message.error("登录状态已过期，请退出之后重新登录。");
      } else {
        Message.error(response.data['errorMsg']);
      }
    }
    super.onResponse(response, handler);
  }
  @override
  void onError(DioError e, handler) {
    // if (e.response != null) {
    //   // The request was made and the server responded with a status code
    //   // that falls out of the range of 2xx and is also not 304.
    //   Message.error(e.response!.data['errorMsg']);
    // } else {
    //   // Something happened in setting up or sending the request that triggered an Error
    //   Message.error('网络错误，请稍后重试');
    // }
    print(e);
    String errorMsg = e.response?.data['errorMsg'] ?? '网络错误，请稍后重试';
    Message.error(errorMsg);
    super.onError(e, handler);
  }
}
