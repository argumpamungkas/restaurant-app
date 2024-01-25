import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/ui/widget/error_view.dart';
import 'package:restaurant_app/ui/widget/item_restaurant.dart';
import 'package:restaurant_app/ui/widget/shimmer_loading_list_data.dart';

class SearchPage extends StatelessWidget {
  static const routeName = "/search_page";

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchRestaurantProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Consumer<SearchRestaurantProvider>(
                      builder: (context, prov, child) {
                    return SearchBar(
                      controller: prov.queryController,
                      hintText: "Search",
                      hintStyle: MaterialStateProperty.resolveWith(
                        (states) => const TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) => prov.setQuery(value),
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          prov.reset();
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  Consumer<SearchRestaurantProvider>(
                      builder: (context, prov, child) {
                    switch (prov.status) {
                      case ResultStatus.loading:
                        return const ShimmerLoadingListDta();
                      case ResultStatus.noData:
                        return _responseData(
                          context,
                          "Data Restaurant not found",
                          Icons.warning_amber_rounded,
                        );
                      case ResultStatus.hasData:
                        return ListView.builder(
                          itemCount: prov.listRestaurant.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            DataItemListRestaurant item =
                                prov.listRestaurant[index];
                            return ItemRestaurant(dataRestaurant: item);
                          },
                        );
                      case ResultStatus.error:
                        return ErrorView(
                          message: prov.message,
                          onPressed: () =>
                              prov.searchRestaurant(prov.queryController.text),
                        );
                      default:
                        return _responseData(
                          context,
                          "Search Restaurant",
                          Icons.search,
                        );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _responseData(
    BuildContext context, String textResponse, IconData iconData) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 64,
          ),
          Text(
            textResponse,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
