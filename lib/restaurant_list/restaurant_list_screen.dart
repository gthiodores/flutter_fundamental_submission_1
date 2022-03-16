import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/di/dependency_provider.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/restaurant_list/restaurant_favorite_list.dart';
import 'package:restaurant_app/restaurant_list/restaurant_list_item.dart';
import 'package:restaurant_app/restaurant_list/restaurant_search_screen.dart';

class RestaurantListScreen extends ConsumerWidget {
  static const route = '/list_restaurant';

  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _restaurantList = ref.watch(fetchRestaurantProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RestaurantSearchScreen.route);
              },
              icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RestaurantFavoritesScreen.route);
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(fetchRestaurantProvider);
        },
        child: _restaurantList.when(
          data: (data) => _buildListItemViews(
              restaurants: data,
              onTap: (id) {
                Navigator.of(context)
                    .pushNamed(RestaurantDetailScreen.route, arguments: id);
              }),
          error: (err, stack) => _buildErrorView(onRetry: () async {
            ref.refresh(fetchRestaurantProvider);
          }),
          loading: () => _buildCenterLoadingView(),
        ),
      ),
    );
  }

  Widget _buildCenterLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorView({Function()? onRetry}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Fetching data failed!"),
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
        return InkWell(
          onTap: () {
            onTap?.call(item.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RestaurantListItem(restaurant: item),
          ),
        );
      },
    );
  }
}
