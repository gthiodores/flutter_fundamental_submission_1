import 'dart:convert';

class SimpleRestaurant {
  SimpleRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  num rating;

  SimpleRestaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? pictureId,
    String? city,
    double? rating,
  }) =>
      SimpleRestaurant(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        pictureId: pictureId ?? this.pictureId,
        city: city ?? this.city,
        rating: rating ?? this.rating,
      );

  factory SimpleRestaurant.fromRawJson(String str) =>
      SimpleRestaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SimpleRestaurant.fromJson(Map<String, dynamic> json) =>
      SimpleRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
