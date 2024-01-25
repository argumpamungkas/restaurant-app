import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/data/api/api_link.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/ui/detail/widget/header_widget.dart';
import 'package:restaurant_app/ui/detail/widget/info_restaurant.dart';
import 'package:restaurant_app/ui/detail/widget/list_drink.dart';
import 'package:restaurant_app/ui/detail/widget/list_food.dart';
import 'package:restaurant_app/ui/detail/widget/list_review.dart';
import 'package:restaurant_app/ui/detail/widget/shimmer_detai.dart';
import 'package:restaurant_app/ui/widget/error_view.dart';

class DetailRestaurant extends StatelessWidget {
  static const routeName = "/detail_restaurant";

  const DetailRestaurant({
    super.key,
    required this.dataRestaurant,
  });

  final DataItemListRestaurant dataRestaurant;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantDetailProvider(dataRestaurant.id),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, data, child) {
              switch (data.status) {
                case ResultStatus.loading:
                  return const ShimmerDetail();
                case ResultStatus.error:
                  return ErrorView(
                    message: data.message,
                    onPressed: () =>
                        data.fetchDetailRestaurant(dataRestaurant.id),
                  );
                case ResultStatus.hasData:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        imageUrl: "$urlImage/${data.restaurantData.pictureId}",
                        dataItemListRestaurant: dataRestaurant,
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRestaurant(restaurant: data.restaurantData),
                            const SizedBox(height: 16),
                            ListFood(menu: data.restaurantData.menus),
                            const SizedBox(height: 16),
                            ListDrink(menu: data.restaurantData.menus),
                            const SizedBox(height: 16),
                            ListReview(
                              idRestaurant: dataRestaurant.id,
                              dataDetail: data.restaurantData,
                              prov: data,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
