import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/tabbar/ps_tabbar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  final List<String> _tabs = [
    '最新',
    '精选',
    '优惠',
    'PS5',
    '定期服务',
    '浏览',
    '最新',
    '精选',
    '优惠',
    'PS5',
    '定期服务',
    '浏览'
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
      child: Center(
          child: PsTabBar(
        tabs: _tabs,
        tabController: _tabController,
      )),
    );
  }

  List<Widget> _buildTabs() {
    return _tabs.map((s) {
      return Tab(
        text: s,
      );
    }).toList();
  }

  int _valueGetter() {
    return _currentIndex;
  }

  void _onTap(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
