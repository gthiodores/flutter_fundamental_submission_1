import '../model/restaurant.dart';
import '../model/result_wrapper.dart';
import '../model/simple_restaurant.dart';

abstract class IRestaurantRepository {
  Stream<Result<List<SimpleRestaurant>>> searchRestaurant(String query);

  Future<List<SimpleRestaurant>> getRestaurantList();

  Future<Restaurant> getRestaurant(String restaurantId);
}
