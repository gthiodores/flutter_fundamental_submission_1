import 'dart:convert';

import 'package:restaurant_app/core/model/simple_restaurant.dart';

class RestaurantSearch {
  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<SimpleRestaurant> restaurants;

  RestaurantSearch copyWith({
    bool? error,
    int? founded,
    List<SimpleRestaurant>? restaurants,
  }) =>
      RestaurantSearch(
        error: error ?? this.error,
        founded: founded ?? this.founded,
        restaurants: restaurants ?? this.restaurants,
      );

  factory RestaurantSearch.fromRawJson(String str) =>
      RestaurantSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<SimpleRestaurant>.from(
            json["restaurants"].map((x) => SimpleRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
