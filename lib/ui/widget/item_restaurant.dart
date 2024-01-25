import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_link.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant.dart';

class ItemRestaurant extends StatelessWidget {
  const ItemRestaurant({super.key, required this.dataRestaurant});

  final DataItemListRestaurant dataRestaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, prov, child) {
      return InkWell(
        onTap: () => Navigation.intentWithData(
            DetailRestaurant.routeName, dataRestaurant),
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(150),
                BlendMode.darken,
              ),
              image: NetworkImage("$urlImage/${dataRestaurant.pictureId}"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataRestaurant.name,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          dataRestaurant.rating.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          dataRestaurant.city,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: FutureBuilder(
                  future: prov.isFavorite(dataRestaurant.id),
                  builder: (context, snapshot) {
                    var isFavorite = snapshot.data ?? false;
                    return isFavorite
                        ? IconButton(
                            onPressed: () =>
                                prov.removeFavorite(dataRestaurant.id),
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                            ),
                          )
                        : IconButton(
                            onPressed: () => prov.addFavorite(dataRestaurant),
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.pink,
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
