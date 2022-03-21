import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:restaurant_app/core/data/api/api_service.dart';
import 'package:restaurant_app/core/data/local/favorite_restaurant_database_impl.dart';
import 'package:restaurant_app/core/data/repository/restaurant_repository.dart';
import 'package:restaurant_app/main.dart';
import 'package:http/http.dart' as http;

import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = "isolate";
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final result = await RestaurantRepository(
      ApiService(http.Client()),
      FavoriteRestaurantDatabaseImpl(),
    ).getAllRestaurant();
    final range = result.length;
    final randomNumber =
        Random().nextInt(range - 1); // Generate a random index for result

    final notificationHelper = NotificationHelper();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result[randomNumber],
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
