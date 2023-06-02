import 'package:flutter/material.dart';
import 'package:flutter_demo/view_model/player.dart';
import 'package:flutter_demo/widgets/appbar/avatar_appbar.dart';

class PlayHomePage extends StatefulWidget {
  const PlayHomePage({super.key});

  @override
  State<PlayHomePage> createState() => _PlayHomePageState();
}

class _PlayHomePageState extends State<PlayHomePage> {
  // 玩家信息
  late Player _player;

  @override
  void initState() {
    super.initState();
    // 初始化测试数据
    _initData();
  }

  void _initData() {
    _player = Player(
        username: '502950715@qq.com', nickName: 'Eric Game', onlineStatus: '1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AvatarAppBar(
        player: _player,
      ),
      body: SafeArea(
        child: ListView(
          children: const [],
        ),
      ),
    );
  }
}
