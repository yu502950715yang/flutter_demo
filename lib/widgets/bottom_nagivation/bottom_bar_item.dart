import 'package:flutter/material.dart';

class BottomBarItem {
  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;

  BottomBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.inactiveColor,
    this.textAlign,
  });
}
