import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/explore/explore_page.dart';
import 'package:flutter_demo/pages/game_library/game_library_page.dart';
import 'package:flutter_demo/pages/play/play_home_page.dart';
import 'package:flutter_demo/pages/store/store_page.dart';
import 'package:flutter_demo/widgets/bottom_nagivation/bottom_bar.dart';
import 'package:flutter_demo/widgets/bottom_nagivation/bottom_bar_item.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Widget> _pageList = [
    const PlayHomePage(),
    const ExplorePage(),
    const StorePage(),
    const GameLibraryPage()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pageList,
      ),
      bottomNavigationBar: BottomBar(
        containerHeight: 56,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        onItemSelected: (index) {
          _currentIndex = index;
          // _pageController.animateToPage(
          //   _currentIndex,
          //   duration: const Duration(milliseconds: 200),
          //   curve: Curves.ease,
          // );
          _pageController.jumpToPage(_currentIndex);
          if (mounted) {
            setState(() {});
          }
        },
        items: [
          BottomBarItem(
            icon: const ImageIcon(AssetImage('assets/images/handle.png')),
            title: const Text('游玩'),
            activeColor: const Color(0xffF4D144),
            textAlign: TextAlign.center,
          ),
          BottomBarItem(
            icon: const ImageIcon(AssetImage('assets/images/explore.png')),
            title: const Text('探索'),
            activeColor: Colors.greenAccent,
            textAlign: TextAlign.center,
          ),
          BottomBarItem(
            icon: const ImageIcon(AssetImage('assets/images/store.png')),
            title: const Text('商店'),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomBarItem(
            icon: const ImageIcon(AssetImage('assets/images/game_library.png')),
            title: const Text('游戏库'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
