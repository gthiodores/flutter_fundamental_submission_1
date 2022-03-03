class Drink {
  late String name;

  Drink({
    required this.name,
  });

  Drink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
