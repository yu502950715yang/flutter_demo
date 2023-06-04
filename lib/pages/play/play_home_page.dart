import 'package:flutter/material.dart';
import 'package:flutter_demo/view_model/player.dart';
import 'package:flutter_demo/view_model/recently_play.dart';
import 'package:flutter_demo/widgets/appbar/avatar_appbar.dart';
import 'package:flutter_demo/widgets/image/net_image.dart';

class PlayHomePage extends StatefulWidget {
  const PlayHomePage({super.key});

  @override
  State<PlayHomePage> createState() => _PlayHomePageState();
}

class _PlayHomePageState extends State<PlayHomePage> {
  // 玩家信息
  late Player _player;
  final List<RecentlyPlay> _gameList = [];

  @override
  void initState() {
    super.initState();
    // 初始化测试数据
    _initData();
  }

  void _initData() {
    _player = Player(
        username: '502950715@qq.com', nickName: 'Eric Game', onlineStatus: '1');
    _gameList.add(RecentlyPlay(
        imageUrl:
            'https://image.api.playstation.com/vulcan/ap/rnd/202010/2915/SqRcyLjZbpK26ej6TnWf43xp.jpg',
        totalTrophy: 80));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AvatarAppBar(
        player: _player,
      ),
      body: ListView.builder(
        itemCount: _gameList.length,
        itemBuilder: (context, index) {
          return _buildListItem(index);
        },
      ),
    );
  }

  Widget _buildListItem(int index) {
    RecentlyPlay recentlyPlay = _gameList[index];
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (index == 0) ...[
            Container(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
              alignment: Alignment.centerLeft,
              child: const Text('最近游玩'),
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 190,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: NetImage(
                url: recentlyPlay.imageUrl,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
