import 'package:flutter/material.dart';

class ContainerColors extends ThemeExtension<ContainerColors> {
  static final light = ContainerColors(
    background: Colors.grey.shade300,
    secoundBackground: Colors.grey.shade400,
    deepBackground: Colors.black,
    deepBackgroundText: Colors.white,
  );
  static final dark = ContainerColors(
    background: Colors.black,
    secoundBackground: Colors.grey.shade800,
    deepBackground: Colors.black,
    deepBackgroundText: Colors.white,
  );

  const ContainerColors({
    required this.background,
    required this.secoundBackground,
    required this.deepBackground,
    required this.deepBackgroundText,
  });

  final Color? background;
  final Color? secoundBackground;
  final Color? deepBackground;
  final Color? deepBackgroundText;

  @override
  ThemeExtension<ContainerColors> copyWith(
      {Color? background,
      Color? secoundBackground,
      Color? deepBackground,
      Color? deepBackgroundText}) {
    return ContainerColors(
      background: this.background,
      secoundBackground: this.secoundBackground,
      deepBackground: this.deepBackground,
      deepBackgroundText: this.deepBackgroundText,
    );
  }

  @override
  ThemeExtension<ContainerColors> lerp(
      covariant ThemeExtension<ContainerColors>? other, double t) {
    if (other is! ContainerColors) {
      return this;
    }
    return ContainerColors(
      background: Color.lerp(background, other.background, t),
      secoundBackground:
          Color.lerp(secoundBackground, other.secoundBackground, t),
      deepBackground: Color.lerp(deepBackground, other.deepBackground, t),
      deepBackgroundText:
          Color.lerp(deepBackgroundText, other.deepBackgroundText, t),
    );
  }
}
