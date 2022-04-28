// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frame_app_flutter/app/api/prefs.dart';
import 'package:package_info/package_info.dart';

class DioHelper {
  static Dio build(String baseUrl) {
    var options = BaseOptions(baseUrl: baseUrl, validateStatus: (value) => value! < 600);

    var dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final info = await PackageInfo.fromPlatform();

          options.headers['Authorization'] = await Prefs.getStringValue(EnumPrefs.TOKEN);
          options.headers['app-version'] = '${info.version}';
          options.headers['platform'] = '${Platform.isAndroid ? 'android' : 'ios'}';
          options.headers['lang'] = 'es';

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) {
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
