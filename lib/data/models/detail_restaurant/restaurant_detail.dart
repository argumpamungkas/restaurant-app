import 'package:restaurant_app/data/models/detail_restaurant/data_detail_restaurant.dart';

class ResponseDetailRestaurant {
  bool error;
  String message;
  DataDetailRestaurant data;

  ResponseDetailRestaurant({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ResponseDetailRestaurant.fromJson(Map<String, dynamic> json) =>
      ResponseDetailRestaurant(
        error: json["error"],
        message: json["message"],
        data: DataDetailRestaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": data.toJson(),
      };
}
