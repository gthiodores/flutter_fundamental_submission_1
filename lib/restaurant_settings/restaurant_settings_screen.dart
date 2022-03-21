import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/restaurant_settings/widgets/restaurant_notif_switch.dart';

class RestaurantSettingsScreen extends ConsumerWidget {
  static String route = "/settings";

  const RestaurantSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: false,
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Tampilkan notifikasi pada pukul 11"),
                RestaurantNotifSwitch()
              ],
            ),
          )
        ],
      ),
    );
  }
}
