import 'package:flutter/material.dart';

class CircularProcessColors extends ThemeExtension<CircularProcessColors> {
  static final light = CircularProcessColors(
    background: Colors.grey.shade300,
    color: Colors.blue,
  );
  static final dark = CircularProcessColors(
    background: Colors.grey.shade900,
    color: Colors.white,
  );

  const CircularProcessColors({
    required this.background,
    required this.color,
  });

  final Color? background;
  final Color? color;

  @override
  ThemeExtension<CircularProcessColors> copyWith(
      {Color? background, Color? color}) {
    return CircularProcessColors(
        background: this.background, color: this.color);
  }

  @override
  ThemeExtension<CircularProcessColors> lerp(
      covariant ThemeExtension<CircularProcessColors>? other, double t) {
    if (other is! CircularProcessColors) {
      return this;
    }
    return CircularProcessColors(
      background: Color.lerp(background, other.background, t),
      color: Color.lerp(color, other.color, t),
    );
  }
}
