import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';

class ResponseListRestaurant {
  bool error;
  String message;
  int count;
  List<DataItemListRestaurant> restaurants;

  ResponseListRestaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory ResponseListRestaurant.fromJson(Map<String, dynamic> json) =>
      ResponseListRestaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<DataItemListRestaurant>.from(
            json["restaurants"].map((x) => DataItemListRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
