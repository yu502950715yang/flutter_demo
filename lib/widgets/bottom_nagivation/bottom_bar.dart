import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/widgets/bottom_nagivation/bottom_bar_item.dart';
import 'package:flutter_demo/widgets/bottom_nagivation/bottom_bar_item_widget.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 28,
    this.containerHeight = 48,
    this.animationDuration = const Duration(milliseconds: 200),
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.easeInOut,
  });

  /// 当前选中
  final int selectedIndex;

  /// 图标大小
  final double iconSize;

  /// 背景颜色
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomBarItem> items;
  final ValueChanged<int> onItemSelected;

  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;

  /// 容器高度
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ??
        Theme.of(context).bottomNavigationBarTheme.backgroundColor;
    // 设置底部控制栏的颜色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: bgColor,
    ));
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: BottomBarItemWidget(
                    item: item,
                    isSelected: index == selectedIndex,
                    backgroundColor: bgColor,
                    animationDuration: animationDuration,
                    itemCornerRadius: itemCornerRadius,
                    iconSize: iconSize),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
