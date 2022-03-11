import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:frame_app_flutter/app/data/prefs.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationUnknown()) {
    _check();
  }

  void _check() async {
    await Prefs.getToken().then(
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
    await Prefs.setToken(value);
    _check();
  }

  Future<void> unauthenticated() async {
    await Prefs.setToken('');
    _check();
  }
}
