import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
              )
          ),
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
        RestaurantListScreen.route: (context) => const RestaurantListScreen()
      },
    );
  }
}
