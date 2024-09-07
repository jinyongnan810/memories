import 'dart:io';

import 'package:dio/dio.dart';

final dio = Dio();

class DioHelper {
  static Future<Response<dynamic>> post({
    required String path,
    required String token,
    required Map<String, dynamic> body,
  }) async {
    return dio.post(
      'https://asia-northeast1-memories-f3a84.cloudfunctions.net/api$path',
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
