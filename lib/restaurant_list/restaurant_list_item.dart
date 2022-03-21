import 'package:flutter/material.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';
import 'package:restaurant_app/core/widget/custom_image.dart';
import 'package:restaurant_app/core/widget/two_tile_text.dart';
import 'package:restaurant_app/restaurant_detail/restaurant_detail_screen.dart';

class RestaurantListItem extends StatelessWidget {
  final SimpleRestaurant restaurant;
  final Function()? onTap;

  const RestaurantListItem({
    Key? key,
    required this.restaurant,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Overrides default on tap behaviour if on tap is provided
        if (onTap != null) {
          onTap?.call();
        } else {
          Navigator.pushNamed(context, RestaurantDetailScreen.route,
              arguments: restaurant.id);
        }
      },
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Hero(
              tag: restaurant.name,
              child: CustomImage(
                url:
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: TwoTileText(
              title: restaurant.name,
              subtitle: restaurant.city,
            ),
          ),
        ],
      ),
    );
  }
}
