import 'package:flutter/material.dart';
import 'package:flutter_demo/common/color/container_colors.dart';

class PsTabBar extends StatelessWidget {
  final List<String> tabs;

  final TabController tabController;

  final double width;

  final double height;

  final double borderRadius;

  /// tabbar左右边距
  final double paddingHorizontal;

  const PsTabBar(
      {super.key,
      required this.tabs,
      required this.tabController,
      this.width = double.infinity,
      this.height = 40,
      this.borderRadius = 20,
      this.paddingHorizontal = 25});

  @override
  Widget build(BuildContext context) {
    final containerColors = Theme.of(context).extension<ContainerColors>();

    return SizedBox(
      width: width,
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: containerColors!.background,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: TabBar(
            tabs: _buildTabs(),
            controller: tabController,
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                color: containerColors.secoundBackground),
            indicatorPadding: const EdgeInsets.all(5),
            labelStyle: const TextStyle(fontSize: 16),
            // 水波纹圆角设置，保证看起来与边框圆角一致
            splashBorderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs() {
    return tabs.map((s) {
      return Tab(
        text: s,
      );
    }).toList();
  }
}
