import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/restaurant_settings/restaurant_setting_provider.dart';

class RestaurantNotifSwitch extends ConsumerWidget {
  const RestaurantNotifSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingNotifState = ref.watch(restaurantSettingNotifier);
    final settingNotif = ref.watch(restaurantSettingNotifier.notifier);

    return Switch.adaptive(
      onChanged: (active) {
        settingNotif.changeNotifPrefState();
      },
      value: settingNotifState,
    );
  }
}
