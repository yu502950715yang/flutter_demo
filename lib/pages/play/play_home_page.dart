import 'package:flutter/material.dart';
import 'package:flutter_demo/view_model/player.dart';
import 'package:flutter_demo/view_model/recently_play.dart';
import 'package:flutter_demo/widgets/appbar/avatar_appbar.dart';
import 'package:flutter_demo/widgets/image/net_image.dart';
import 'package:flutter_demo/widgets/progress_indicator/circle_progress.dart';
import 'package:flutter_demo/widgets/trophy_row.dart/trophy_row.dart';

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
        totalTrophy: 80,
        bronzeTrophy: 27));

    _gameList.add(RecentlyPlay(
        imageUrl:
            'https://image.api.playstation.com/vulcan/ap/rnd/202010/2915/SqRcyLjZbpK26ej6TnWf43xp.jpg',
        totalTrophy: 46,
        goldTrophy: 1,
        silverTrophy: 7,
        bronzeTrophy: 21));

    _gameList.add(RecentlyPlay(
        imageUrl:
            'https://image.api.playstation.com/vulcan/ap/rnd/202010/2915/SqRcyLjZbpK26ej6TnWf43xp.jpg',
        totalTrophy: 41,
        goldTrophy: 1,
        bronzeTrophy: 19));
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          if (index == 0) ...[
            Container(
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                '最近游玩',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              print('游戏详情');
            },
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
          ),
          GestureDetector(
            onTap: () {
              print('奖杯');
            },
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('奖杯', style: TextStyle(fontSize: 16)),
                    Icon(Icons.chevron_right),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${recentlyPlay.winTotalTrophy}',
                          style: const TextStyle(fontSize: 22),
                        ),
                        const Text(
                          '已获得',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    CircleProgress(
                        value: recentlyPlay.trophySchedule, diameter: 80),
                    Column(
                      children: [
                        Text(
                          '${recentlyPlay.totalTrophy}',
                          style: const TextStyle(fontSize: 22),
                        ),
                        const Text(
                          '可获得的',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TrophyRow(
                  platinumNum: recentlyPlay.platinumTrophy,
                  goldNum: recentlyPlay.goldTrophy,
                  silverNum: recentlyPlay.silverTrophy,
                  bronzeNum: recentlyPlay.bronzeTrophy,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
