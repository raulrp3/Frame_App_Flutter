// ignore_for_file: lines_longer_than_80_chars

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<String> getToken() async => (await _prefs).getString(_TAG_TOKEN) ?? '';
  static Future<bool> setToken(String value) async {
    return (await _prefs).setString(_TAG_TOKEN, value);
  }
}

const _TAG_TOKEN = 'TOKEN';

Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();
