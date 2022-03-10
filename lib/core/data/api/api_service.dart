import 'dart:convert';

import 'package:restaurant_app/core/model/customer_review.dart';
import 'package:restaurant_app/core/model/restaurant_detail.dart';
import 'package:restaurant_app/core/model/restaurant_list.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/core/model/restaurant_search.dart';

import '../../model/restaurant.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  final String _listUrl = "$_baseUrl/list";
  final String _detailUrl = "$_baseUrl/detail";
  final String _searchUrl = "$_baseUrl?q=";
  final String _addCommentsUrl = "$_baseUrl/review";

  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse(_listUrl));

    if (response.statusCode == 200) {
      return RestaurantList.fromRawJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<Restaurant> getRestaurant(String restaurantId) async {
    final response = await http.get(Uri.parse("$_detailUrl/$restaurantId"));

    if (response.statusCode == 200) {
      final detail = RestaurantDetail.fromRawJson(response.body);
      return detail.restaurant;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<RestaurantSearch> getRestaurantSearchResult(String query) async {
    final response = await http.get(Uri.parse("$_searchUrl/$query"));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromRawJson(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<CustomerReview>> addComment({
    required String id,
    required String name,
    required String review,
  }) async {
    final jsonObject = json.encode({"name": name, "review": review});
    final response = await http.put(
      Uri.parse(_addCommentsUrl),
      headers: {
        "Content-Type": " application/x-www-form-urlencoded | application/json"
      },
      body: jsonObject,
    );

    if (response.statusCode == 200) {
      final receivedJsonObject = json.decode(response.body);
      final List reviewsJson = receivedJsonObject["customerReviews"];
      return reviewsJson.map((obj) => CustomerReview.fromJson(obj)).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
