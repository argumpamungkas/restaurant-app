import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/helpers/preferences_helper.dart';

class SettingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  SettingProvider({required this.preferencesHelper}) {
    _getDarkTheme();
    _getReminder();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isReminder = false;
  bool get isReminder => _isReminder;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getDarkTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkThemeActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getDarkTheme();
  }

  void _getReminder() async {
    _isReminder = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  void enableReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getReminder();
  }
}
