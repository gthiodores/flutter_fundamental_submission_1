import 'package:flutter/material.dart';
import 'package:restaurant_app/core/widget/custom_image.dart';
import 'package:restaurant_app/core/widget/two_tile_text.dart';

import '../core/model/restaurant.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static const route = "/detail_restaurant";

  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Restaurant? restaurant =
        ModalRoute.of(context)?.settings.arguments as Restaurant?;
    return _buildScreen(restaurant);
  }

  Widget _buildScreen(Restaurant? restaurant) {
    if (restaurant == null) {
      return _buildEmptyScreen();
    }

    return _buildCustomScrollRestaurantDetail(restaurant);
  }

  Widget _buildEmptyScreen() {
    return Scaffold(
      body: const Center(
        child: Text("Restoran tidak ditemukan!"),
      ),
      appBar: AppBar(title: const Text("Restaurant App")),
    );
  }

  Widget _buildCustomScrollRestaurantDetail(Restaurant restaurant) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150,
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
                    url: restaurant.pictureId,
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
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = restaurant.foods[index];
                return Text(item.name);
              }, childCount: restaurant.foods.length),
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
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = restaurant.drinks[index];
                return Text(item.name);
              }, childCount: restaurant.drinks.length),
            ),
          ),
        ],
      ),
    );
  }

}
