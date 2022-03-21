import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/util/background_service.dart';
import 'package:restaurant_app/core/util/navigation.dart';
import 'package:restaurant_app/core/util/notification_helper.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_favorite_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_list_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_search_screen.dart';
import 'package:restaurant_app/restaurant_settings/restaurant_settings_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService backgroundService = BackgroundService();

  backgroundService.initializeIsolate();

  if (Platform.isAndroid) {
    AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.green,
              secondary: Colors.green,
            ),
        appBarTheme: AppBarTheme(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          )),
          centerTitle: true,
          elevation: 0,
          titleTextStyle: Theme.of(context)
              .appBarTheme
              .titleTextStyle
              ?.copyWith(color: Colors.green),
        ),
      ),
      initialRoute: RestaurantListScreen.route,
      routes: {
        RestaurantDetailScreen.route: (context) =>
            const RestaurantDetailScreen(),
        RestaurantListScreen.route: (context) => const RestaurantListScreen(),
        RestaurantSearchScreen.route: (context) =>
            const RestaurantSearchScreen(),
        RestaurantFavoritesScreen.route: (context) =>
            const RestaurantFavoritesScreen(),
        RestaurantSettingsScreen.route: (context) =>
            const RestaurantSettingsScreen(),
      },
      navigatorKey: navigatorKey,
    );
  }
}
