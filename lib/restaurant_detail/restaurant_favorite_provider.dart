import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/di/dependency_provider.dart';
import 'package:restaurant_app/core/domain/use_case/add_restaurant_to_favorite.dart';
import 'package:restaurant_app/core/domain/use_case/get_restaurant_favorite_state.dart';
import 'package:restaurant_app/core/domain/use_case/remove_restaurant_from_favorite.dart';

import '../core/model/restaurant.dart';

final restaurantFavoriteNotifier = StateNotifierProvider.family
    .autoDispose<RestaurantFavoriteNotifier, bool, Restaurant>(
        (ref, restaurant) {
  return RestaurantFavoriteNotifier(
    restaurant,
    ref.watch(getRestaurantFavoriteStateProvider),
    ref.watch(addRestaurantToFavoriteProvider),
    ref.watch(removeRestaurantFromFavoriteProvider),
  );
});

class RestaurantFavoriteNotifier extends StateNotifier<bool> {
  final Restaurant _restaurant;
  final GetRestaurantFavoriteState _getRestaurantFavoriteState;
  final AddRestaurantToFavorite _addRestaurantToFavorite;
  final RemoveRestaurantFromFavorite _removeRestaurantFromFavorite;

  RestaurantFavoriteNotifier(
    this._restaurant,
    this._getRestaurantFavoriteState,
    this._addRestaurantToFavorite,
    this._removeRestaurantFromFavorite,
  ) : super(false) {
    _getFavoriteState();
  }

  void _getFavoriteState() async {
    state = await _getRestaurantFavoriteState.execute(_restaurant.id);
  }

  void addToFavorite() async {
    await _addRestaurantToFavorite.execute(_restaurant);
    _getFavoriteState();
  }

  void removeFromFavorite() async {
    print(_restaurant.id);
    await _removeRestaurantFromFavorite.execute(_restaurant.id);
    _getFavoriteState();
  }
}
