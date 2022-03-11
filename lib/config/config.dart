import 'package:frame_app_flutter/config/environment.dart';
import 'package:frame_app_flutter/config/service_locator.dart';

class Config {
  static void setup(BuildVariant buildVariant) {
    Environment.init(buildVariant);
    ServiceLocator.setup(Environment.instance);
  }
}
