import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://cark-f3fjembga0f6btek.uaenorth-01.azurewebsites.net/api/', // 🔁 url السيرفر بتاعنا من الباك
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // ✅ إضافة Pretty Dio Logger
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      compact: true,
      maxWidth: 90,
    ));

    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     final prefs = await SharedPreferences.getInstance();
    //     final token = prefs.getString('access_token');
    //
    //     if (token != null) {
    //       options.headers['Authorization'] = 'Bearer $token';
    //     }
    //
    //     return handler.next(options);
    //   },
    //   onError: (error, handler) {
    //     // تقدر تعالج هنا مثلاً لو حصل Unauthorized
    //     return handler.next(error);
    //   },
    //   onResponse: (response, handler) {
    //     return handler.next(response);
    //   },
    // ));
  }


  // GET request
  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // POST request
  Future<Response> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT request
  Future<Response> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE request
  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
