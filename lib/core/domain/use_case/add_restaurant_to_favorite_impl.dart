import 'package:restaurant_app/core/domain/repository/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/domain/use_case/add_restaurant_to_favorite.dart';

import '../../model/restaurant.dart';

class AddRestaurantToFavoriteImpl extends AddRestaurantToFavorite {
  final IRestaurantRepository _repository;

  AddRestaurantToFavoriteImpl(this._repository);

  @override
  Future<void> execute(Restaurant restaurant) async {
    await _repository.addRestaurantToFavorite(restaurant);
  }

}