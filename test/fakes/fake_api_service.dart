import 'package:restaurant_app/core/data/api/api_service_interface.dart';
import 'package:restaurant_app/core/model/restaurant.dart';
import 'package:restaurant_app/core/model/restaurant_detail.dart';
import 'package:restaurant_app/core/model/restaurant_list.dart';
import 'package:restaurant_app/core/model/restaurant_search.dart';
import 'package:http/http.dart' as http;

import 'fake_http_client.dart';

class FakeApiService extends IApiService {
  final http.Client _client = mockHttpClient;

  @override
  Future<Restaurant> getRestaurant(String restaurantId) async {
    final response = await _client
        .get(Uri.parse("https://restaurant-api.dicoding.dev/detail"));

    if (response.statusCode == 200) {
      final detail = RestaurantDetail.fromRawJson(response.body);
      return detail.restaurant;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<RestaurantList> getRestaurantList() async {
    final response = await _client
        .get(Uri.parse("https://restaurant-api.dicoding.dev/list"));

    if (response.statusCode == 200) {
      return RestaurantList.fromRawJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<RestaurantSearch> getRestaurantSearchResult(String query) async {
    final response = await _client
        .get(Uri.parse("https://restaurant-api-dicoding.dev/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromRawJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
