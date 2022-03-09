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
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    yield cacheList;

    try {
      final fetchResult = await _apiService.getRestaurantSearchResult(query);
      for (var item in fetchResult.restaurants) {
        if (!cacheList.any((element) => element.id == item.id)) {
          _inMemoryCache.add(item);
          yield _inMemoryCache;
        }
      }
    } catch (e) {
      yield _inMemoryCache;
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
    if (_detailCache == null || _detailCache?.id == restaurantId) {
      try {
        _detailCache = await _apiService.getRestaurant(restaurantId);
      } catch (e) {
        rethrow;
      }
    }

    return _detailCache!;
  }
}
