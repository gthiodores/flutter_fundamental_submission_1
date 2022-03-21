import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurant_app/core/domain/use_case/set_restaurant_notification.dart';
import 'package:restaurant_app/core/util/background_service.dart';
import 'package:restaurant_app/core/util/preference_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetRestaurantNotificationImpl extends SetRestaurantNotification {
  final int _alarmId = 1;

  @override
  Future<void> execute(bool shouldSchedule) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(shouldScheduleNotification, shouldSchedule);

    if (shouldSchedule) {
      // Schedule notification
      final time = DateTime.now();
      final scheduleTime =
          DateTime(time.year, time.month, time.day, 11, 0, 0, 0);

      // If time > 11:00 schedules the alarm tomorrow
      if (time.hour >= 11) {
        scheduleTime.add(const Duration(days: 1));
      }

      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        _alarmId,
        BackgroundService.callback,
        startAt: scheduleTime,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
    } else {
      // Cancel scheduled notification
      await AndroidAlarmManager.cancel(_alarmId);
    }
  }
}
