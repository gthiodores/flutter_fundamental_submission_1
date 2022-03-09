import 'dart:convert';

import 'package:restaurant_app/core/model/restaurant.dart';

class RestaurantDetail {
  RestaurantDetail({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  RestaurantDetail copyWith({
    bool? error,
    String? message,
    Restaurant? restaurant,
  }) =>
      RestaurantDetail(
        error: error ?? this.error,
        message: message ?? this.message,
        restaurant: restaurant ?? this.restaurant,
      );

  factory RestaurantDetail.fromRawJson(String str) =>
      RestaurantDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}
