import 'package:restaurant_app/data/models/detail_restaurant/catagory_detail_restaurant.dart';
import 'package:restaurant_app/data/models/detail_restaurant/customer_review_detail_restaurant.dart';
import 'package:restaurant_app/data/models/detail_restaurant/list_menu_detail_restaurant.dart';

class DataDetailRestaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<CategoryDetailRestaurant> categories;
  ListMenuDetailRestaurant menus;
  double rating;
  List<CustomerReviewDetailRestaurant> customerReviews;

  DataDetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory DataDetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DataDetailRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<CategoryDetailRestaurant>.from(json["categories"]
            .map((x) => CategoryDetailRestaurant.fromJson(x))),
        menus: ListMenuDetailRestaurant.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReviewDetailRestaurant>.from(
            json["customerReviews"]
                .map((x) => CustomerReviewDetailRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
