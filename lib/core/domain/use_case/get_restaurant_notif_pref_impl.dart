import 'package:restaurant_app/core/domain/use_case/get_restaurant_notif_pref.dart';
import 'package:restaurant_app/core/util/preference_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetRestaurantNotifPrefImpl extends GetRestaurantNotifPref {
  @override
  Future<bool> execute() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getBool(shouldScheduleNotification) ?? false;
  }
}
