class CategoryDetailRestaurant {
  String name;

  CategoryDetailRestaurant({
    required this.name,
  });

  factory CategoryDetailRestaurant.fromJson(Map<String, dynamic> json) =>
      CategoryDetailRestaurant(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
