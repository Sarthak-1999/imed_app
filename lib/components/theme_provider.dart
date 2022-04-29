import 'dart:math';

import 'package:flutter/material.dart';

class MyThemes {
  ThemeMode themeMode = ThemeMode.dark;
  // bool get isDarkMode
  //  {

  //    return themeMode == ThemeMode.dark;

  //  }
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black38,
    cardColor: Colors.grey[900],
    bottomAppBarColor: Colors.grey[900],
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: Colors.white),
      headline1: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
    ),
    colorScheme: const ColorScheme.dark(),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    //Colors.primaries[Random().nextInt(Colors.accents.length)],
    cardColor: Colors.white,
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: Colors.black),
      headline1: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headlineLarge: TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      actionsIconTheme: IconThemeData(color: Colors.black),
    ),
  );
}
