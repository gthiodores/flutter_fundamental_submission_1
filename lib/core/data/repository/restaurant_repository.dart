import 'package:restaurant_app/core/data/api/api_service.dart';
import 'package:restaurant_app/core/domain/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/model/restaurant.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';

class RestaurantRepository implements IRestaurantRepository {
  final ApiService _apiService;
  final List<SimpleRestaurant> _inMemoryCache = [];
  Restaurant? _detailCache;

  RestaurantRepository(this._apiService);

  /// Returns a cached list of items matching the query and then make a network call
  /// and refresh the data with matching data from the network.
  @override
  Stream<List<SimpleRestaurant>> searchRestaurant(String query) async* {
    final cacheList = _inMemoryCache
        .where((element) =>
        element.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    yield cacheList;

    try {
      final fetchResult = await _apiService.getRestaurantSearchResult(query);
      for (var item in fetchResult.restaurants) {
        if (!cacheList.any((element) => element.id == item.id)) {
          _inMemoryCache.add(item);
          cacheList.add(item);
          yield cacheList;
        }
      }
    } catch (e) {
      yield cacheList;
    }
  }

  // Read from the inMemoryCache if any is cached
  @override
  Future<List<SimpleRestaurant>> getRestaurantList() async {
    try {
      if (_inMemoryCache.isEmpty) {
        final result = await _apiService.getRestaurantList();
        _inMemoryCache.addAll(result.restaurants);
      }
    } catch (e) {
      rethrow;
    }
    return _inMemoryCache;
  }

  @override
  Future<Restaurant> getRestaurant(String restaurantId) async {
    if (_detailCache == null) {
      return await _getRestaurantHelper(restaurantId);
    }

    return _detailCache?.id == restaurantId ? _detailCache! : await _getRestaurantHelper(restaurantId);
  }

  Future<Restaurant> _getRestaurantHelper(restaurantId) async {
    print("Getting restaurant from the API");
    final item = await _apiService.getRestaurant(restaurantId);
    _detailCache = item;
    return item;
  }
}
