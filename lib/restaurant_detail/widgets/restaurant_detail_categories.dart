import 'package:flutter/material.dart';
import 'package:restaurant_app/core/model/category.dart';

class RestaurantCategoriesGrid extends StatelessWidget {
  final List<Category> _categories;
  final int gridCount;

  const RestaurantCategoriesGrid(
    this._categories, {
    Key? key,
    required this.gridCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final item = _categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                padding: const EdgeInsets.all(4),
                color: Colors.green,
                child: Center(
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
          childCount: _categories.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridCount,
          childAspectRatio: 2,
        ),
      ),
    );
  }
}
