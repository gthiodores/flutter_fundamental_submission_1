import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/di/dependency_provider.dart';
import 'package:restaurant_app/core/widget/custom_image.dart';
import 'package:restaurant_app/core/widget/two_tile_text.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_favorite_provider.dart';
import 'package:restaurant_app/restaurant_detail/widgets/restaurant_detail_categories.dart';

import '../core/model/restaurant.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  static const route = "/detail_restaurant";

  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String _restaurantId =
        ModalRoute.of(context)?.settings.arguments as String;
    final _restaurant = ref.watch(fetchRestaurantDetailProvider(_restaurantId));
    return Scaffold(
      body: _restaurant.when(
        data: (data) => _buildCustomScrollRestaurantDetail(data, context, ref),
        error: (err, stack) => _buildErrorView(onRetry: () {
          ref.refresh(fetchRestaurantDetailProvider(_restaurantId));
        }),
        loading: _buildCenterLoadingView,
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

  Widget _buildCustomScrollRestaurantDetail(
    Restaurant restaurant,
    BuildContext context,
    WidgetRef ref,
  ) {
    final _favorite = ref.watch(restaurantFavoriteNotifier(restaurant));
    final _favoriteNotifier =
        ref.watch(restaurantFavoriteNotifier(restaurant).notifier);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          leading: ClipOval(
            child: Material(
              color: Colors.green,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (_favorite) {
                  _favoriteNotifier.removeFromFavorite();
                } else {
                  _favoriteNotifier.addToFavorite();
                }
              },
              icon: Icon(
                _favorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.pink,
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              restaurant.name,
            ),
            background: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              child: Hero(
                tag: restaurant.name,
                child: CustomImage(
                  url:
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TwoTileText(
                  title: restaurant.name,
                  subtitle: restaurant.city,
                  titleSize: 24,
                ),
                Text('${restaurant.rating} / 5'),
              ],
            ),
          ),
        ),
        RestaurantCategoriesGrid(
          restaurant.categories,
          gridCount: 4,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Text(restaurant.description),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Food",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = restaurant.menus.foods[index];
                return Text(item.name);
              },
              childCount: restaurant.menus.foods.length,
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Drinks",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = restaurant.menus.drinks[index];
                return Text(item.name);
              },
              childCount: restaurant.menus.drinks.length,
            ),
          ),
        ),
      ],
    );
  }
}
