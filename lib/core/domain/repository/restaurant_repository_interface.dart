import '../../model/restaurant.dart';
import '../../model/result_wrapper.dart';
import '../../model/simple_restaurant.dart';

abstract class IRestaurantRepository {
  Stream<Result<List<SimpleRestaurant>>> searchRestaurant(String query);

  Future<List<SimpleRestaurant>> getRestaurantList();

  Future<Restaurant> getRestaurant(String restaurantId);

  Future<bool> isRestaurantFavorite(String id);

  Future<List<SimpleRestaurant>> getFavoriteRestaurantList();

  Future<void> addRestaurantToDatabase(SimpleRestaurant restaurant);

  Future<void> addRestaurantToFavorite(Restaurant restaurant);

  Future<void> removeRestaurantFromFavorite(String id);

  Future<List<SimpleRestaurant>> getAllRestaurant();
}
