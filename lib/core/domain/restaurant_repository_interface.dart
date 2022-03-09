import '../model/restaurant.dart';
import '../model/simple_restaurant.dart';

abstract class IRestaurantRepository {
  Stream<List<SimpleRestaurant>> searchRestaurant(String query);

  Future<List<SimpleRestaurant>> getRestaurantList();

  Future<Restaurant> getRestaurant(String restaurantId);
}
