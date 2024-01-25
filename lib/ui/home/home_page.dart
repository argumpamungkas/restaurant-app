import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/provider/schedule_provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/widget/item_restaurant.dart';
import 'package:restaurant_app/ui/search/search_page.dart';
import 'package:restaurant_app/ui/widget/error_view.dart';
import 'package:restaurant_app/ui/widget/shimmer_loading_list_data.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home_page";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurant",
          style: TextStyle(
            fontFamily: fontPlayball,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            logoApp,
            color: Colors.blueGrey,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              SearchPage.routeName,
            ),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => _dialogSettings(),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recommendations",
                  softWrap: true,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "The best restaurants you can visit in Indonesia with their own specialities",
                  softWrap: true,
                ),
                Consumer<RestauranProvider>(
                  builder: (context, data, child) {
                    switch (data.status) {
                      case ResultStatus.loading:
                        return const ShimmerLoadingListDta();
                      case ResultStatus.noData:
                        return Center(
                          child: Text(data.message),
                        );
                      case ResultStatus.error:
                        return ErrorView(
                          message: data.message,
                          onPressed: () => data.fetchRestaurantList(),
                        );
                      case ResultStatus.hasData:
                        return ListView.builder(
                          itemCount: data.listRestaurant.length,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DataItemListRestaurant dataItem =
                                data.listRestaurant[index];
                            return ItemRestaurant(
                              dataRestaurant: dataItem,
                            );
                          },
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dialogSettings() {
    return AlertDialog(
      title: const Text(
        "Settings",
        textAlign: TextAlign.center,
      ),
      content: Consumer<SettingProvider>(
        builder: (context, prov, child) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                value: prov.isDarkTheme,
                onChanged: (value) => prov.enableDarkTheme(value),
                activeColor: Colors.blueGrey,
                title: Text(
                  "Dark Theme",
                  softWrap: true,
                  style: TextStyle(
                      color: prov.isDarkTheme ? Colors.white : Colors.black),
                ),
                tileColor: Colors.transparent,
              ),
              Consumer<ScheduleProvider>(builder: (context, provSchedule, _) {
                return SwitchListTile(
                  value: prov.isReminder,
                  onChanged: (value) {
                    prov.enableReminder(value);
                    provSchedule.scheduleRestaurant(value);
                  },
                  activeColor: Colors.blueGrey,
                  title: Text(
                    "Daily Reminder",
                    softWrap: true,
                    style: TextStyle(
                        color: prov.isDarkTheme ? Colors.white : Colors.black),
                  ),
                  tileColor: Colors.transparent,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
