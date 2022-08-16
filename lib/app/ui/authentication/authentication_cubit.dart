// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frame_app_flutter/app/api/prefs.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationUnknown()) {
    _check();
  }

  void _check() async {
    await Prefs.getStringValue(EnumPrefs.TOKEN).then(
      (value) {
        if (value.isEmpty) {
          emit(AuthenticationUnauthenticated());
        } else {
          emit(AuthenticationAuthenticated());
        }
      },
    );
  }

  Future<void> authenticated(String value) async {
    await Prefs.setStringValue(value, EnumPrefs.TOKEN);
    _check();
  }

  Future<void> unauthenticated() async {
    await Prefs.setStringValue('', EnumPrefs.TOKEN);
    _check();
  }
}
