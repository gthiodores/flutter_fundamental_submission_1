import 'package:restaurant_app/core/model/restaurant.dart';

abstract class AddRestaurantToFavorite {
  Future<void> execute(Restaurant restaurant);
}