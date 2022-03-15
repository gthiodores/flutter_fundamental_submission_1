import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/data/api/api_service_interface.dart';
import 'package:restaurant_app/core/data/repository/restaurant_repository.dart';
import 'package:restaurant_app/core/domain/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';
import 'package:http/http.dart' as http;

import '../data/api/api_service.dart';
import '../model/restaurant.dart';
import '../model/result_wrapper.dart';

final Provider<http.Client> _clientProvider = Provider((ref) => http.Client());
final Provider<IApiService> _apiProvider = Provider((ref) {
  final httpClient = ref.read(_clientProvider);
  return ApiService(httpClient);
});
final Provider<IRestaurantRepository> _restaurantRepoProvider = Provider((ref) {
  final api = ref.read(_apiProvider);
  return RestaurantRepository(api);
});
final fetchRestaurantProvider =
    FutureProvider.autoDispose<List<SimpleRestaurant>>((ref) {
  final repository = ref.read(_restaurantRepoProvider);
  return repository.getRestaurantList();
});
final fetchSearchProvider =
    StreamProvider.family.autoDispose<Result<List<SimpleRestaurant>>, String>(
  (ref, query) {
    final repository = ref.read(_restaurantRepoProvider);
    return repository.searchRestaurant(query);
  },
);
final fetchRestaurantDetailProvider =
    FutureProvider.family.autoDispose<Restaurant, String>((ref, id) {
  final repository = ref.read(_restaurantRepoProvider);
  return repository.getRestaurant(id);
});
