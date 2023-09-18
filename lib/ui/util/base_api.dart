// @dart=2.9
import 'package:dio/dio.dart';
import 'package:enstaller/core/constant/api_urls.dart';

class BaseApi {

  static final BaseApi _BaseApi = BaseApi._internal();
  Dio _dio;

  static BaseApi getInstance() {
    return _BaseApi;
  }

  factory BaseApi() => _BaseApi;

  BaseApi._internal() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiUrls.baseUrl,
      connectTimeout: 35000,
      receiveTimeout: 35000,
    );
    _dio = Dio(baseOptions);

    _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true));
    _dio.interceptors.add(HeaderInterceptor());
  }

  Dio getClient() {
    return _dio;
  }

  Future<void> postAPI() async {
    return await _dio.post("/", options: Options(extra: {'refresh': true}));
  }

}

class HeaderInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options , dynamic handler) async {
    options.headers = {
      "Content-type": "application/json",
      "accept": "application/json"
    };
    print("header ${options.headers.toString()}");
    return super.onRequest(options , null);
  }
}
