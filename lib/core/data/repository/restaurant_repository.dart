import 'package:restaurant_app/core/data/local/favorite_restaurant_database.dart';
import 'package:restaurant_app/core/domain/repository/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/model/restaurant.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';

import '../../model/result_wrapper.dart';
import '../api/api_service_interface.dart';

class RestaurantRepository implements IRestaurantRepository {
  final IApiService _apiService;
  final IFavoriteRestaurantDatabase _database;
  final List<SimpleRestaurant> _inMemoryCache = [];
  Restaurant? _detailCache;

  RestaurantRepository(this._apiService, this._database);

  @override
  Stream<Result<List<SimpleRestaurant>>> searchRestaurant(String query) async* {
    final cacheList = _inMemoryCache
        .where((element) =>
            element.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    yield Result.loading(data: cacheList);

    try {
      final fetchResult = await _apiService.getRestaurantSearchResult(query);
      for (var item in fetchResult.restaurants) {
        if (!cacheList.any((element) => element.id == item.id)) {
          _inMemoryCache.add(item);
          cacheList.add(item);
          yield Result.success(cacheList);
        }
      }
    } catch (e) {
      yield Result.error("An error occured", data: cacheList);
    }
  }

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

    return _detailCache?.id == restaurantId
        ? _detailCache!
        : await _getRestaurantHelper(restaurantId);
  }

  Future<Restaurant> _getRestaurantHelper(restaurantId) async {
    final item = await _apiService.getRestaurant(restaurantId);
    _detailCache = item;
    return item;
  }

  @override
  Future<void> addRestaurantToFavorite(Restaurant restaurant) async {
    final SimpleRestaurant mappedRestaurant = SimpleRestaurant(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
    );
    print("adding to database : ${mappedRestaurant.id}");
    await _database.addRestaurantToFavorite(mappedRestaurant.toJson());
  }

  @override
  Future<List<SimpleRestaurant>> getFavoriteRestaurantList() async {
    return await _database.getFavoriteRestaurantList();
  }

  @override
  Future<bool> isRestaurantFavorite(String id) async {
    return await _database.isRestaurantFavorite(id);
  }

  @override
  Future<void> removeRestaurantFromFavorite(String id) async {
    return await _database.removeRestaurantFromFavorite(id);
  }
}
