import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/hex_color.dart';

class AppTheme {
  static Color lightPrimaryColor = HexColor('#DF0054');
  static Color darkPrimaryColor = HexColor('#480032');
  static Color secondaryColor = HexColor('#FF8B6A');
  static Color accentColor = HexColor('#FFD2BB');

  /// 明亮主题
  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: lightPrimaryColor,
      secondary: secondaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey)),
  );

  /// 深色主题
  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: darkPrimaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      backgroundColor: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
    ),
  );
}
