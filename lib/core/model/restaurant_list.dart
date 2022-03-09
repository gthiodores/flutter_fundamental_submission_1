import 'dart:convert';

import 'package:restaurant_app/core/model/simple_restaurant.dart';

class RestaurantList {
  RestaurantList({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<SimpleRestaurant> restaurants;

  RestaurantList copyWith({
    bool? error,
    String? message,
    int? count,
    List<SimpleRestaurant>? restaurants,
  }) =>
      RestaurantList(
        error: error ?? this.error,
        message: message ?? this.message,
        count: count ?? this.count,
        restaurants: restaurants ?? this.restaurants,
      );

  factory RestaurantList.fromRawJson(String str) =>
      RestaurantList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<SimpleRestaurant>.from(
            json["restaurants"].map((x) => SimpleRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
