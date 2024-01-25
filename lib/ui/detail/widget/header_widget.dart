import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.imageUrl,
    required this.dataItemListRestaurant,
  });

  final String imageUrl;
  final DataItemListRestaurant dataItemListRestaurant;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300.withAlpha(120),
                  ),
                  child: const Icon(
                    (Icons.keyboard_arrow_left),
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              Consumer<DatabaseProvider>(builder: (context, prov, child) {
                return FutureBuilder(
                    future: prov.isFavorite(dataItemListRestaurant.id),
                    builder: (context, snapshot) {
                      var isFavorite = snapshot.data ?? false;
                      return Container(
                        alignment: Alignment.bottomRight,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300.withAlpha(120),
                        ),
                        child: isFavorite
                            ? IconButton(
                                onPressed: () => prov
                                    .removeFavorite(dataItemListRestaurant.id),
                                icon: const Icon(Icons.favorite),
                                color: Colors.pink,
                              )
                            : IconButton(
                                onPressed: () =>
                                    prov.addFavorite(dataItemListRestaurant),
                                icon: const Icon(Icons.favorite_border),
                                color: Colors.pink,
                              ),
                      );
                    });
              }),
            ],
          ),
        ),
      ],
    );
  }
}
