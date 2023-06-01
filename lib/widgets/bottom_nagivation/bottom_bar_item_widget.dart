import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/bottom_nagivation/bottom_bar_item.dart';

class BottomBarItemWidget extends StatelessWidget {
  const BottomBarItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
  });

  final double iconSize;
  final bool isSelected;
  final BottomBarItem item;
  final Color? backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    double selectedWidth = 100;
    double unSelectedWidth = 50;
    Color? unSelectIconColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;
    //Flutter的“语义(Semantics)”可以注释应用的UI中其他的Widget。它具有将近五十个属性，
    //可用于为屏幕阅读器和其他基于语义分析的工具提供描述，元数据以及更多内容。
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? selectedWidth : unSelectedWidth,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
              isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // 不允许用户滚动
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? selectedWidth : unSelectedWidth,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected
                          ? item.activeColor.withOpacity(1)
                          : item.inactiveColor ?? unSelectIconColor),
                  child: item.icon,
                ),
                if (isSelected)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      // DefaultTextStyle.merge可以允许您创建一个默认的文本样式，该样式会被其所有的子节点继承。
                      child: DefaultTextStyle.merge(
                        style: TextStyle(
                            color: item.inactiveColor,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
