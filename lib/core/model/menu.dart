import 'dart:convert';

import 'category.dart';

class Menu {
  Menu({
    required this.foods,
    required this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  Menu copyWith({
    List<Category>? foods,
    List<Category>? drinks,
  }) =>
      Menu(
        foods: foods ?? this.foods,
        drinks: drinks ?? this.drinks,
      );

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
    drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}
