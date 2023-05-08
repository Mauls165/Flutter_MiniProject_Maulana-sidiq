import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _SaveThemeBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadThemeFromBOx() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBOx() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBOx() ? ThemeMode.light : ThemeMode.dark);
    _SaveThemeBox(!_loadThemeFromBOx());
  }
}
