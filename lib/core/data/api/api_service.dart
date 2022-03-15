import 'package:restaurant_app/core/model/restaurant_detail.dart';
import 'package:restaurant_app/core/model/restaurant_list.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/model/restaurant_search.dart';

import '../../model/restaurant.dart';
import 'api_service_interface.dart';

class ApiService extends IApiService {
  final http.Client _client;

  ApiService(this._client);

  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  final String _listUrl = "$_baseUrl/list";
  final String _detailUrl = "$_baseUrl/detail";
  final String _searchUrl = "$_baseUrl?q=";

  @override
  Future<RestaurantList> getRestaurantList() async {
    final response = await _client.get(Uri.parse(_listUrl));

    if (response.statusCode == 200) {
      return RestaurantList.fromRawJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<Restaurant> getRestaurant(String restaurantId) async {
    final response = await _client.get(Uri.parse("$_detailUrl/$restaurantId"));

    if (response.statusCode == 200) {
      final detail = RestaurantDetail.fromRawJson(response.body);
      return detail.restaurant;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<RestaurantSearch> getRestaurantSearchResult(String query) async {
    final response = await _client.get(Uri.parse("$_searchUrl/$query"));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromRawJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
