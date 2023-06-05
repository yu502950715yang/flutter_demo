import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/tabbar/ps_tabbar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    '官方最新消息',
    'PS Blog',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: 25,
            left: 0,
            child: PsTabBar(
              tabs: _tabs,
              tabController: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
