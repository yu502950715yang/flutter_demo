import 'package:flutter/material.dart';

class ThemeColor {
  static List<Color> containerLinearGradientColors() {
    MediaQueryData mediaQuery = MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.first);
    var brightness = mediaQuery.platformBrightness;
    if (brightness == Brightness.dark) {
      return [
        Colors.black12,
        Colors.black,
      ];
    } else {
      return [
        Colors.grey.shade100,
        Colors.white,
      ];
    }
  }
}
