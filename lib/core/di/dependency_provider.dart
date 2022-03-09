import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/data/repository/restaurant_repository.dart';
import 'package:restaurant_app/core/domain/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';

import '../data/api/api_service.dart';

final _apiProvider = Provider((ref) => ApiService());
final Provider<IRestaurantRepository> _restaurantRepoProvider = Provider((ref) {
  final api = ref.read(_apiProvider);
  return RestaurantRepository(api);
});
final fetchRestaurantProvider = FutureProvider.autoDispose<List<SimpleRestaurant>>((ref) {
  final repository = ref.read(_restaurantRepoProvider);
  return repository.getRestaurantList();
});
