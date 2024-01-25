import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPref;

  PreferencesHelper({required this.sharedPref});

  static const darkTheme = "DARK_THEME";
  static const reminder = "DAILY_REMINDER";

  Future<bool> get isDarkThemeActive async {
    final prefs = await sharedPref;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPref;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isDailyReminderActive async {
    final prefs = await sharedPref;
    return prefs.getBool(reminder) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await sharedPref;
    prefs.setBool(reminder, value);
  }
}
