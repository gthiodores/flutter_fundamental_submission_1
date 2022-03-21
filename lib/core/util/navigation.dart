import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String route, Object arguments) {
    navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}