import 'package:flutter/material.dart';
import 'package:flutter_demo/common/color/container_colors.dart';

class PsTabBar extends StatefulWidget {
  final List<String> tabs;

  final TabController tabController;

  final double height;

  final double borderRadius;

  /// tabbar左右边距
  final double paddingHorizontal;

  const PsTabBar(
      {super.key,
      required this.tabs,
      required this.tabController,
      this.height = 40,
      this.borderRadius = 20,
      this.paddingHorizontal = 25});

  @override
  State<PsTabBar> createState() => _PsTabBarState();
}

class _PsTabBarState extends State<PsTabBar> {
  late ScrollController _scrollController;
  // 存储选项卡的 GlobalKey
  List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabKeys = List.generate(widget.tabs.length, (_) => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final containerColors = Theme.of(context).extension<ContainerColors>();
    return SizedBox(
      height: widget.height,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: containerColors!.background?.withOpacity(0.8),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: TabBar(
            tabs: _buildTabs(),
            controller: widget.tabController,
            onTap: (index) {
              double maxOffset = _scrollController.position.maxScrollExtent;
              if (maxOffset == 0) {
                return;
              }
              double offset = index == 0 ? 0 : widget.paddingHorizontal;
              for (int i = 0; i < index; i++) {
                RenderBox tabRenderBox =
                    _tabKeys[i].currentContext?.findRenderObject() as RenderBox;
                offset += tabRenderBox.size.width + 5; // 累加前面选项卡的宽度
              }
              double temp = maxOffset - offset;
              if (offset > maxOffset || temp < 100) {
                offset = maxOffset;
              }
              _scrollController.animateTo(offset,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut);
            },
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius)),
                color: containerColors.secoundBackground),
            indicatorPadding: const EdgeInsets.all(5),
            labelStyle: const TextStyle(fontSize: 14),
            // 水波纹圆角设置，保证看起来与边框圆角一致
            splashBorderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius)),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      tabs.add(Tab(
        key: _tabKeys[i],
        text: widget.tabs[i],
      ));
    }
    return tabs;
  }
}
