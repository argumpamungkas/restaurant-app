import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/widget/item_restaurant.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/favorite_page";

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorite",
          style: TextStyle(
            fontFamily: fontPlayball,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, prov, child) {
          switch (prov.resultStatus) {
            case ResultStatus.noData:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_special_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Favorite Restaurant is Empty",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            default:
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            itemCount: prov.listFavorite.length,
            itemBuilder: (context, index) {
              DataItemListRestaurant dataItem = prov.listFavorite[index];
              return ItemRestaurant(dataRestaurant: dataItem);
            },
          );
        },
      ),
    );
  }
}
