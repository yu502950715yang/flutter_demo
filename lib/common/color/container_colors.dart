import 'package:flutter/material.dart';

class ContainerColors extends ThemeExtension<ContainerColors> {
  static final light = ContainerColors(
    background: Colors.grey.shade300,
    secoundBackground: Colors.grey.shade400,
  );
  static final dark = ContainerColors(
    background: Colors.black,
    secoundBackground: Colors.grey.shade800,
  );

  const ContainerColors({
    required this.background,
    required this.secoundBackground,
  });

  final Color? background;
  final Color? secoundBackground;

  @override
  ThemeExtension<ContainerColors> copyWith(
      {Color? background, Color? secoundBackground}) {
    return ContainerColors(
        background: this.background, secoundBackground: this.secoundBackground);
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
    );
  }
}
