import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetail extends StatelessWidget {
  const ShimmerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _widgetShimmer(
          child: Container(
            height: mediaQuery.height * 0.3,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _widgetShimmer(
                child: Container(
                  height: 20,
                  width: mediaQuery.width / 2,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _widgetShimmer(
                child: Container(
                  height: 20,
                  width: mediaQuery.width / 3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _widgetShimmer(
                child: Container(
                  height: 20,
                  width: mediaQuery.width / 4,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              _widgetShimmer(
                child: Container(
                  height: 20,
                  width: mediaQuery.width / 3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _widgetShimmer(
                child: Container(
                  height: mediaQuery.height * 0.3,
                  width: mediaQuery.width,
                  color: Colors.black,
                ),
              ),
              // FOODS
              const SizedBox(height: 16),
              _widgetShimmer(
                child: Container(
                  height: 20,
                  width: mediaQuery.width / 3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _widgetShimmer(
                child: Container(
                  height: 20,
                  width: mediaQuery.width / 3,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  _widgetShimmer(
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget _widgetShimmer({required Widget child}) {
  return Consumer<SettingProvider>(builder: (context, prov, childs) {
    return Shimmer.fromColors(
      baseColor: prov.isDarkTheme ? Colors.black : Colors.grey.shade300,
      highlightColor:
          prov.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
      child: child,
    );
  });
}
