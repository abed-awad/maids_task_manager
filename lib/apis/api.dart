import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/apis/urls.dart';
import 'package:task_manager/helpers/helper.dart';
import 'package:task_manager/db/local_storage.dart';
import 'package:task_manager/screens/auth/login.dart';
import 'package:task_manager/styles/snackbar.dart';

class ApiService {
  late Dio _dio;

  ApiService._();

  static Future<ApiService> create() async {
    final apiService = ApiService._();
    await apiService._init();
    return apiService;
  }

  Future<Response?> getApi({
    required String url,
    Map<String, dynamic>? params,
  }) async {
    try {
      final res = await _dio.get(url, queryParameters: params);
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<Response?> postApi({
    required String url,
    required body,
    Map<String, dynamic>? params,
  }) async {
    try {
      final res = await _dio.post(
        url,
        data: body,
        queryParameters: params,
      );
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<Response?> putApi({
    required String url,
    required body,
    Map<String, dynamic>? params,
  }) async {
    try {
      final res = await _dio.put(
        url,
        data: body,
        queryParameters: params,
      );
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<Response?> deleteApi({
    required String url,
    Map<String, dynamic>? params,
  }) async {
    try {
      final res = await _dio.delete(
        url,
        queryParameters: params,
      );
      return res;
    } catch (e) {
      return null;
    }
  }

  void _initializeInterceptors() {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        request: false,
        error: true,
        responseHeader: false,
        requestHeader: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (error.message != null &&
              error.message!.contains("SocketException")) {
            showErrorSnackBar(
              navigatorKey.currentContext!,
              'No Internet connection',
            );
          } else {
            showErrorSnackBar(
              navigatorKey.currentContext!,
              error.error != null && error.error.toString().isNotEmpty
                  ? error.error.toString()
                  : error.message ?? "Error",
            );
          }

          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _init() async {
    final token = await LocalStorage.getStringValue(USER_TOKEN);

    _dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 3),
        headers: token.isEmpty ? null : {"Authorization": "Bearer $token"},
        validateStatus: (_) => true,
      ),
    );

    _initializeInterceptors();
  }
}
