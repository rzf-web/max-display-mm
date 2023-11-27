import 'package:dio/dio.dart';
import 'package:max_display_app/services/api/api_helper.dart';

class ApiService {
  static var _dio = Dio();

  static get(
    String url, {
    Map<String, dynamic>? queryParameters,
    int? secTimeOut,
  }) async {
    try {
      if (secTimeOut != null) _dio = Dio(getOptionTimeOut(secTimeOut));
      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: getHeader()),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }

  static post(String url, {Object? data}) async {
    try {
      var response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: getHeader(header: {'undefined': 'multipart/form-data'}),
        ),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }

  static put(String url, {Object? data}) async {
    try {
      var response = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: getHeader(header: {'undefined': 'multipart/form-data'}),
        ),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }

  static delete(String url) async {
    try {
      var response = await _dio.delete(
        url,
        options: Options(headers: getHeader()),
      );
      return response;
    } on DioException catch (e) {
      return e;
    }
  }
}
