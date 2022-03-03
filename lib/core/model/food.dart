class Food {
  late String name;

  Food({
    required this.name,
  });

  Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
