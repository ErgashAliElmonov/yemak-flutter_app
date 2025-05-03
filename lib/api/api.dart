import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  late Dio dio;
  final _storage = const FlutterSecureStorage();
  String? _token;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.yemak-test.uz",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Accept-Language": "uz",
        },
      ),
    );

    _initializeInterceptors();
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = await _storage.read(key: "token");
  }

  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          _token ??= await _storage.read(key: "token");
          if (_token != null) {
            options.headers["Authorization"] = "Bearer $_token";
          }

          print("📡 [REQUEST] => ${options.method} ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // ignore: avoid_print
          print(
            "✅ [RESPONSE] => [${response.statusCode}] ${response.requestOptions.uri}",
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("❌ [ERROR] => [${e.response?.statusCode}] ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  Future<Response> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException error) {
    if (error.response != null) {
      return 'Server Error: ${error.response?.statusCode} ${error.response?.statusMessage}';
    } else {
      return 'Connection Error: ${error.message}';
    }
  }

  // Agar kerak bo'lsa tokenni yangilash uchun
  Future<void> updateToken(String newToken) async {
    _token = newToken;
    await _storage.write(key: "token", value: newToken);
  }
}
