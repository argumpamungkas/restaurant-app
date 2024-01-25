import 'package:flutter/material.dart';

const String fontPlayball = "Playball";
const String logoApp = "assets/images/logo.png";

const Color primaryColor = Color(0xFF4682A9);
const Color secondaryColor = Color(0xFFADC4CE);

const Color darkPrimaryColor = Color(0xFF000000);
const Color darkSecondaryColor = Color(0xFF749BC2);

final ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        onPrimary: Colors.black,
      ),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  listTileTheme: listThemeLight,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
  ),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Colors.black,
    ),
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: darkPrimaryColor,
        secondary: darkSecondaryColor,
        onPrimary: Colors.black,
      ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  listTileTheme: listThemeLight,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
  ),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
      color: Colors.white,
    ),
  ),
);

final ListTileThemeData listThemeLight = ListTileThemeData(
  titleTextStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  tileColor: Colors.blueGrey.shade50,
  minVerticalPadding: 16,
  horizontalTitleGap: 8,
);

final ListTileThemeData listThemeDark = ListTileThemeData(
  titleTextStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  tileColor: Colors.blueGrey.shade50,
  minVerticalPadding: 16,
  horizontalTitleGap: 8,
);
