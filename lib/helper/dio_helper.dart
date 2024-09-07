import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio();

class DioHelper {
  static Future<Response<dynamic>> post({
    required String path,
    required String token,
    Map<String, dynamic>? body,
  }) async {
    return dio.post(
      '${dotenv.env['SERVER_API_PREFIX']}$path',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        validateStatus: (status) => status != null && status < 400,
        followRedirects: false,
      ),
      data: body,
    );
  }

  static Future<Response<dynamic>> delete({
    required String path,
    required String token,
    Map<String, dynamic>? body,
  }) async {
    return dio.delete(
      '${dotenv.env['SERVER_API_PREFIX']}$path',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        validateStatus: (status) => status != null && status < 400,
        followRedirects: false,
      ),
      data: body,
    );
  }
}
