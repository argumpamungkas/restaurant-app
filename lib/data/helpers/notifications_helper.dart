import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/data/models/list_restaurant/restaurant_list.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationsHelper {
  static NotificationsHelper? _instance;

  NotificationsHelper._internal() {
    _instance = this;
  }

  factory NotificationsHelper() => _instance ?? NotificationsHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializeSettingAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializeSettingIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializeSettingAndroid, iOS: initializeSettingIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        final payload = details.payload;
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ResponseListRestaurant listRestaurant) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "Restaurant Idea";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var randomIndex = Random().nextInt(listRestaurant.restaurants.length - 1);

    DataItemListRestaurant dataRestaurant =
        listRestaurant.restaurants[randomIndex];

    var titleNotification = "<b>${dataRestaurant.name}</b>";
    var titleRestaurant = dataRestaurant.city;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(dataRestaurant.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var dataRestaurant =
            DataItemListRestaurant.fromJson(json.decode(payload));
        Navigation.intentWithData(route, dataRestaurant);
      },
    );
  }
}
