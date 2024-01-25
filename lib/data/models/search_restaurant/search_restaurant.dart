import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';

class ResponseSearchRestaurant {
  bool error;
  int founded;
  List<DataItemListRestaurant> restaurants;

  ResponseSearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory ResponseSearchRestaurant.fromJson(Map<String, dynamic> json) =>
      ResponseSearchRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<DataItemListRestaurant>.from(
            json["restaurants"].map((x) => DataItemListRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
