import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/di/dependency_provider.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_list_item.dart';

import '../core/model/simple_restaurant.dart';

class RestaurantFavoritesScreen extends ConsumerWidget {
  static String route = "/favorites";

  const RestaurantFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(fetchRestaurantFavoriteListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: favorites.when(
        data: (data) {
          return _buildListItemViews(
              restaurants: data,
              onTap: (id) async {
                await Navigator.pushNamed(context, RestaurantDetailScreen.route,
                    arguments: id);
                ref.refresh(fetchRestaurantFavoriteListProvider);
              });
        },
        error: (error, stack) {
          return _buildErrorView();
        },
        loading: () {
          return _buildLoadingScreen();
        },
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorView({Function()? onRetry}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("An error occurred!"),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }

  Widget _buildListItemViews({
    required List<SimpleRestaurant> restaurants,
    Function(String)? onTap,
  }) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final item = restaurants[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RestaurantListItem(
            restaurant: item,
            onTap: () {
              onTap?.call(item.id);
            },
          ),
        );
      },
    );
  }
}
