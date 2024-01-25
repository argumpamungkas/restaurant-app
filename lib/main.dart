import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/helpers/db_helper.dart';
import 'package:restaurant_app/data/helpers/notifications_helper.dart';
import 'package:restaurant_app/data/helpers/preferences_helper.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/provider/bottom_navigation_bar_provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/schedule_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/bottom_nav_bar.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant.dart';
import 'package:restaurant_app/ui/home/home_page.dart';
import 'package:restaurant_app/ui/search/search_page.dart';
import 'package:restaurant_app/ui/splash/splash_page.dart';
import 'package:restaurant_app/utils/background_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationsHelper notificationsHelper = NotificationsHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationsHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SettingProvider(
              preferencesHelper: PreferencesHelper(
                sharedPref: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider(
              create: (context) => BottomNavigationBarProvider()),
          ChangeNotifierProvider(create: (context) => RestauranProvider()),
          ChangeNotifierProvider(
            create: (context) => DatabaseProvider(
              databaseHelper: DatabaseHelper(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => ScheduleProvider(),
          )
        ],
        child: Consumer<SettingProvider>(
          builder: (context, prov, child) {
            return MaterialApp(
              title: "Restaurant App",
              theme: prov.themeData,
              initialRoute: SplashPage.routeName,
              navigatorKey: navigatorKey,
              routes: {
                SplashPage.routeName: (context) => const SplashPage(),
                BottomNavBar.routeName: (context) => BottomNavBar(),
                HomePage.routeName: (context) => const HomePage(),
                DetailRestaurant.routeName: (context) => DetailRestaurant(
                      dataRestaurant: ModalRoute.of(context)!.settings.arguments
                          as DataItemListRestaurant,
                    ),
                SearchPage.routeName: (context) => const SearchPage(),
              },
            );
          },
        ));
  }
}
