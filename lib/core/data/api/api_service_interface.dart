import '../../model/restaurant.dart';
import '../../model/restaurant_list.dart';
import '../../model/restaurant_search.dart';

abstract class IApiService {
  Future<RestaurantSearch> getRestaurantSearchResult(String query);

  Future<Restaurant> getRestaurant(String restaurantId);

  Future<RestaurantList> getRestaurantList();
}
