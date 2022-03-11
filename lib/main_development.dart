// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

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

  Config.setup(BuildVariant.dev);

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(App()),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
