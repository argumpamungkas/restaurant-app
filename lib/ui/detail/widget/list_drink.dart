import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/detail_restaurant/list_menu_detail_restaurant.dart';
import 'package:restaurant_app/ui/detail/widget/custom_list.dart';

class ListDrink extends StatelessWidget {
  const ListDrink({
    super.key,
    required this.menu,
  });

  final ListMenuDetailRestaurant menu;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.local_drink_outlined),
            SizedBox(width: 4),
            Text(
              "Drinks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: menu.drinks
                .map((drink) => CustomList(dataName: drink.name))
                .toList(),
          ),
        ),
      ],
    );
  }
}
