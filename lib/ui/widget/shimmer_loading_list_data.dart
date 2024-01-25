import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingListDta extends StatelessWidget {
  const ShimmerLoadingListDta({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, prov, child) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: prov.isDarkTheme ? Colors.black : Colors.grey.shade300,
          highlightColor:
              prov.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
          child: Card(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 100,
            ),
          ),
        ),
      );
    });
  }
}
