import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:frame_app_flutter/app/app.dart';
import 'package:frame_app_flutter/app/app_bloc_observer.dart';
import 'package:frame_app_flutter/config/config.dart';
import 'package:frame_app_flutter/config/environment.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  Config.setup(BuildVariant.beta);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
