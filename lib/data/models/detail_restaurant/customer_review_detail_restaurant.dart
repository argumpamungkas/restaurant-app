class CustomerReviewDetailRestaurant {
  String name;
  String review;
  String date;

  CustomerReviewDetailRestaurant({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReviewDetailRestaurant.fromJson(Map<String, dynamic> json) =>
      CustomerReviewDetailRestaurant(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}
