import 'dart:convert';

import 'drink.dart';
import 'food.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late List<Food> foods;
  late List<Drink> drinks;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    final menusItem = json['menus'];
    final foodItems = menusItem['foods'] as List;
    final drinkItems = menusItem['drinks'] as List;

    id = json["id"];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'];
    foods = foodItems.map((e) => Food.fromJson(e)).toList();
    drinks = drinkItems.map((e) => Drink.fromJson(e)).toList();
  }

}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final decoded = jsonDecode(json)['restaurants'] as List;
  return decoded.map((json) => Restaurant.fromJson(json)).toList();
}
