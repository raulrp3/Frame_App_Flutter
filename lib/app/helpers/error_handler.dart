// ignore_for_file: always_declare_return_types

import 'package:flutter/material.dart';
import 'package:frame_app_flutter/app/helpers/messages.dart';
//import 'package:template_flutter/l10n/l10n.dart';

class ErrorHandler {
  static handler(BuildContext context, int code, String message) {
    //final l10n = context.l10n;

    switch (code) {
      case 404:
        Messages.showMessage(context, message, Colors.red, Colors.white);
        break;
    }
  }
}
