import 'package:restaurant_app/data/models/detail_restaurant/catagory_detail_restaurant.dart';

class ListMenuDetailRestaurant {
  List<CategoryDetailRestaurant> foods;
  List<CategoryDetailRestaurant> drinks;

  ListMenuDetailRestaurant({
    required this.foods,
    required this.drinks,
  });

  factory ListMenuDetailRestaurant.fromJson(Map<String, dynamic> json) =>
      ListMenuDetailRestaurant(
        foods: List<CategoryDetailRestaurant>.from(
            json["foods"].map((x) => CategoryDetailRestaurant.fromJson(x))),
        drinks: List<CategoryDetailRestaurant>.from(
            json["drinks"].map((x) => CategoryDetailRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
