import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/helpers/notifications_helper.dart';
import 'package:restaurant_app/provider/setting_provider.dart';
import 'package:restaurant_app/ui/bottom_nav_bar.dart';
import 'package:restaurant_app/ui/detail/detail_restaurant.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "/splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final NotificationsHelper _notificationsHelper = NotificationsHelper();

  @override
  void initState() {
    super.initState();
    _notificationsHelper
        .configureSelectNotificationSubject(DetailRestaurant.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, prov, child) {
      return Scaffold(
        backgroundColor: prov.isDarkTheme ? Colors.black : Colors.blueGrey,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    logoApp,
                    height: 120,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        "Restaurant App",
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontPlayball,
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 120),
                      ),
                    ],
                    totalRepeatCount: 1,
                    onNext: (p0, p1) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pushReplacementNamed(
                          context,
                          BottomNavBar.routeName,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomCenter,
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(text: "by "),
                    TextSpan(
                      text: "Argumelar Pamungkas",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
