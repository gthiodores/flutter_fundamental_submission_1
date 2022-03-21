import 'package:restaurant_app/core/model/simple_restaurant.dart';

abstract class IFavoriteRestaurantDatabase {
  Future<void> addRestaurantToDatabase(Map<String, dynamic> dbObject);

  Future<List<SimpleRestaurant>> getFavoriteRestaurantList();

  Future<void> addRestaurantToFavorite(Map<String, dynamic> dbObject);

  Future<void> removeRestaurantFromFavorite(String id);

  Future<bool> isRestaurantFavorite(String id);

  Future<List<SimpleRestaurant>> getAllRestaurants();
}
