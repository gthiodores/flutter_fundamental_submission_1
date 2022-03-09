import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant_list/widgets/restaurant_search_widget.dart';

class RestaurantSearchScreen extends StatelessWidget {
  static const route = "/search";

  const RestaurantSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: false,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: const RestaurantSearchWidget(),
    );
  }
}
