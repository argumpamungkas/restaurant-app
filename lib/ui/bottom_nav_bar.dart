import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/bottom_navigation_bar_provider.dart';
import 'package:restaurant_app/ui/favorite/favorite_page.dart';
import 'package:restaurant_app/ui/home/home_page.dart';

class BottomNavBar extends StatelessWidget {
  static const routeName = "/bottom_nav_bar";

  BottomNavBar({super.key});

  final List<Widget> _pageScreen = [
    const HomePage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider =
        Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: _pageScreen[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (value) => provider.setIndex(value),
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.grey.shade400,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: "Favorite",
            ),
          ]),
    );
  }
}
