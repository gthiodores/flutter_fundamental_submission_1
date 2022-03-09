import 'package:flutter/material.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';
import 'package:restaurant_app/core/widget/custom_image.dart';
import 'package:restaurant_app/core/widget/two_tile_text.dart';

class RestaurantListItem extends StatelessWidget {
  final SimpleRestaurant restaurant;

  const RestaurantListItem({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Hero(
            tag: restaurant.name,
            child: CustomImage(
              url: "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
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
    );
  }
}
