import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/di/dependency_provider.dart';
import 'package:restaurant_app/core/domain/use_case/get_restaurant_notif_pref.dart';
import 'package:restaurant_app/core/domain/use_case/set_restaurant_notification.dart';

final restaurantSettingNotifier =
    StateNotifierProvider.autoDispose<RestaurantSettingNotifier, bool>(
  (ref) => RestaurantSettingNotifier(
    ref.read(getRestaurantNotificationPref),
    ref.read(setRestaurantNotification),
  ),
);

class RestaurantSettingNotifier extends StateNotifier<bool> {
  final GetRestaurantNotifPref _getRestaurantNotifPref;
  final SetRestaurantNotification _setRestaurantNotification;

  RestaurantSettingNotifier(
    this._getRestaurantNotifPref,
    this._setRestaurantNotification,
  ) : super(false) {
    _getRestaurantNotifPrefState();
  }

  void _getRestaurantNotifPrefState() async {
    state = await _getRestaurantNotifPref.execute();
  }

  void changeNotifPrefState() async {
    await _setRestaurantNotification.execute(!state);
    _getRestaurantNotifPrefState();
  }
}
