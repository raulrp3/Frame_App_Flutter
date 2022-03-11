// ignore_for_file: lines_longer_than_80_chars, cascade_invocations

import 'package:dio/dio.dart';
import 'package:frame_app_flutter/app/data/dio_helper.dart';
import 'package:frame_app_flutter/app/ui/authentication/authentication_cubit.dart';
import 'package:frame_app_flutter/config/environment.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup(Environment environment) {
    getIt.registerSingleton<Dio>(DioHelper.build(environment.baseApiUrl));

    //REPOSITORIES
    //CUBITS
    getIt.registerLazySingleton<AuthenticationCubit>(() => AuthenticationCubit());
  }
}
