import 'package:flutter/material.dart';
import 'package:flutter_demo/common/color/circular_progress_colors.dart';
import 'package:flutter_demo/common/color/container_colors.dart';
import 'package:flutter_demo/utils/hex_color.dart';

class AppTheme {
  static Color lightPrimaryColor = HexColor('#DF0054');
  static Color darkPrimaryColor = HexColor('#480032');
  static Color secondaryColor = HexColor('#FF8B6A');
  static Color accentColor = HexColor('#FFD2BB');

  /// 明亮主题
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'SST',
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.white,
      secondary: Colors.grey.shade100,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey)),
    iconTheme: const IconThemeData(color: Colors.grey),
    extensions: <ThemeExtension<dynamic>>[
      CircularProcessColors.light,
      ContainerColors.light,
    ],
  );

  /// 深色主题
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'SST',
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.black,
      secondary: Colors.black54,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.blueGrey,
      backgroundColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
    ),
    extensions: <ThemeExtension<dynamic>>[
      CircularProcessColors.dark,
      ContainerColors.dark,
    ],
  );
}
