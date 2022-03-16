import 'package:restaurant_app/core/data/api/api_service_interface.dart';
import 'package:restaurant_app/core/domain/repository/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/model/restaurant.dart';
import 'package:restaurant_app/core/model/result_wrapper.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';

import 'fake_api_service.dart';

class FakeRestaurantRepository extends IRestaurantRepository {
  final List<SimpleRestaurant> _restaurantList = [];
  final List<SimpleRestaurant> _favoriteList = [];

  Restaurant? _detail;

  final IApiService fakeAPI = FakeApiService();

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
    return _favoriteList.add(mappedRestaurant);
  }

  @override
  Future<List<SimpleRestaurant>> getFavoriteRestaurantList() async {
    return _favoriteList;
  }

  @override
  Future<bool> isRestaurantFavorite(String id) async {
    return _favoriteList.any((restaurant) => restaurant.id == id);
  }

  @override
  Future<void> removeRestaurantFromFavorite(String id) async {
    return _favoriteList.removeWhere((restaurant) => restaurant.id == id);
  }

  @override
  Future<Restaurant> getRestaurant(String restaurantId) async {
    return _detail ??= await fakeAPI.getRestaurant("");
  }

  @override
  Future<List<SimpleRestaurant>> getRestaurantList() async {
    final apiResult = await fakeAPI.getRestaurantList();
    _restaurantList.addAll(apiResult.restaurants);
    return _restaurantList;
  }

  @override
  Stream<Result<List<SimpleRestaurant>>> searchRestaurant(String query) async* {
    yield Result.loading();
    yield Result.success(
      _restaurantList
          .where((restaurant) => restaurant.name.startsWith(query))
          .toList(),
    );
  }
}
