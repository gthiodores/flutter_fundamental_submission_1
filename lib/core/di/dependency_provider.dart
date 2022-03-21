import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/core/data/api/api_service_interface.dart';
import 'package:restaurant_app/core/data/local/favorite_restaurant_database_impl.dart';
import 'package:restaurant_app/core/data/repository/restaurant_repository.dart';
import 'package:restaurant_app/core/domain/use_case/add_restaurant_to_database_impl.dart';
import 'package:restaurant_app/core/domain/use_case/add_restaurant_to_favorite_impl.dart';
import 'package:restaurant_app/core/domain/use_case/get_restaurant_favorite_state_impl.dart';
import 'package:restaurant_app/core/domain/repository/restaurant_repository_interface.dart';
import 'package:restaurant_app/core/domain/use_case/get_restaurant_notif_pref_impl.dart';
import 'package:restaurant_app/core/domain/use_case/remove_restaurant_from_favorite.dart';
import 'package:restaurant_app/core/domain/use_case/remove_restaurant_from_favorite_impl.dart';
import 'package:restaurant_app/core/domain/use_case/set_restaurant_notification_impl.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/util/background_service.dart';
import 'package:restaurant_app/core/util/notification_helper.dart';
import 'package:restaurant_app/main.dart';

import '../data/api/api_service.dart';
import '../data/local/favorite_restaurant_database.dart';
import '../domain/use_case/add_restaurant_to_database.dart';
import '../domain/use_case/add_restaurant_to_favorite.dart';
import '../domain/use_case/get_restaurant_favorite_state.dart';
import '../model/restaurant.dart';
import '../model/result_wrapper.dart';

final Provider<http.Client> _clientProvider = Provider((ref) => http.Client());

final Provider<IFavoriteRestaurantDatabase> _databaseProvider =
    Provider((ref) => FavoriteRestaurantDatabaseImpl());

final Provider<IApiService> _apiProvider = Provider((ref) {
  final httpClient = ref.read(_clientProvider);
  return ApiService(httpClient);
});

final Provider<IRestaurantRepository> _restaurantRepoProvider = Provider((ref) {
  final api = ref.read(_apiProvider);
  final database = ref.read(_databaseProvider);
  return RestaurantRepository(api, database);
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

final fetchRestaurantFavoriteListProvider =
    FutureProvider.autoDispose<List<SimpleRestaurant>>((ref) {
  final repository = ref.read(_restaurantRepoProvider);
  return repository.getFavoriteRestaurantList();
});

final getRestaurantFavoriteStateProvider =
    Provider.autoDispose<GetRestaurantFavoriteState>((ref) {
  final repository = ref.read(_restaurantRepoProvider);
  return GetRestaurantFavoriteStateImpl(repository);
});

final addRestaurantToFavoriteProvider =
    Provider.autoDispose<AddRestaurantToFavorite>((ref) {
  final repository = ref.read(_restaurantRepoProvider);
  return AddRestaurantToFavoriteImpl(repository);
});

final removeRestaurantFromFavoriteProvider =
    Provider.autoDispose<RemoveRestaurantFromFavorite>((ref) {
  final repository = ref.read(_restaurantRepoProvider);
  return RemoveRestaurantFromFavoriteImpl(repository);
});

final addRestaurantToDatabaseProvider =
    Provider.autoDispose<AddRestaurantToDatabase>((ref) {
  final repository = ref.read(_restaurantRepoProvider);
  return AddRestaurantToDatabaseImpl(repository);
});

final setRestaurantNotification =
    Provider((ref) => SetRestaurantNotificationImpl());

final getRestaurantNotificationPref =
    Provider((ref) => GetRestaurantNotifPrefImpl());
