import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/detail_restaurant/data_detail_restaurant.dart';
import 'package:restaurant_app/ui/detail/widget/custom_list.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class InfoRestaurant extends StatelessWidget {
  const InfoRestaurant({
    super.key,
    required this.restaurant,
  });

  final DataDetailRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant.name,
          softWrap: true,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            RatingBar.builder(
              initialRating: restaurant.rating,
              allowHalfRating: true,
              ignoreGestures: true,
              maxRating: 5.0,
              unratedColor: Colors.amber.shade100,
              itemSize: 20,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (_) {},
            ),
            const SizedBox(width: 4),
            Text(
              "(${restaurant.rating})",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              size: 16,
              color: Colors.red,
            ),
            const SizedBox(width: 4),
            Text(
              "${restaurant.address}, ${restaurant.city}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(
              Icons.category_outlined,
              size: 16,
            ),
            SizedBox(width: 4),
            Text(
              "Category",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          children: restaurant.categories
              .map((category) => CustomList(dataName: category.name))
              .toList(),
        ),
        const SizedBox(height: 8),
        const Text(
          "Description",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ReadMoreText(
          "${restaurant.description} ",
          trimLines: 4,
          colorClickableText: Colors.blueGrey,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'Read more',
          trimExpandedText: 'Less',
          style: const TextStyle(color: Colors.grey),
          moreStyle: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
          lessStyle: const TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
