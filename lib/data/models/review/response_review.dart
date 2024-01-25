import 'package:restaurant_app/data/models/review/customer_review.dart';

class ResponseReview {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  ResponseReview({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory ResponseReview.fromJson(Map<String, dynamic> json) => ResponseReview(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
