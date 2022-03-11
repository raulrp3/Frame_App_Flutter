// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frame_app_flutter/app/data/prefs.dart';
import 'package:frame_app_flutter/app/helpers/exception.dart';
import 'package:package_info/package_info.dart';

class DioHelper {
  static Dio build(String baseUrl) {
    var options = BaseOptions(baseUrl: baseUrl, validateStatus: (value) => value! < 600);

    var dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final _info = await PackageInfo.fromPlatform();

          options.headers['Authorization'] = await Prefs.getToken();
          options.headers['app-version'] = '${_info.version}';
          options.headers['platform'] = '${Platform.isAndroid ? 'android' : 'ios'}';
          options.headers['lang'] = 'es';

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) {
          switch (error.type) {
            case DioErrorType.other:
              throw MException(code: 500, message: '');
            case DioErrorType.connectTimeout:
              throw MException(code: 501, message: '');
            case DioErrorType.receiveTimeout:
              throw MException(code: 502, message: '');
            default:
              throw MException(code: 600, message: '');
          }
        },
      ),
    );

    return dio;
  }
}
