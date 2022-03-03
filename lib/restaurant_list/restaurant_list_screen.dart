import 'package:flutter/material.dart';
import 'package:restaurant_app/core/model/restaurant.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_list_item.dart';

class RestaurantListScreen extends StatelessWidget {
  static const route = '/list_restaurant';

  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant')),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/resources/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> items = parseRestaurant(snapshot.data);
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RestaurantDetailScreen.route,
                      arguments: item);
                },
                child: RestaurantListItem(
                  restaurant: item,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
