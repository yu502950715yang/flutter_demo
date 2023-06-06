import 'package:flutter/material.dart';
import 'package:flutter_demo/common/scroll_configuration/over_scroll_behavior.dart';
import 'package:flutter_demo/view_model/recently_play.dart';
import 'package:flutter_demo/widgets/image/net_image.dart';
import 'package:flutter_demo/widgets/progress_indicator/circle_progress.dart';
import 'package:flutter_demo/widgets/tabbar/ps_tabbar.dart';
import 'package:flutter_demo/widgets/trophy_row.dart/trophy_row.dart';

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
  final List<RecentlyPlay> _gameList = [];

  double _tabbarOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    _gameList.add(RecentlyPlay(
        imageUrl:
            'https://image.api.playstation.com/vulcan/ap/rnd/202107/3100/aUvkDs1bjV2Nd5SuNTzRECpi.jpg',
        totalTrophy: 80,
        bronzeTrophy: 27));

    _gameList.add(RecentlyPlay(
        imageUrl:
            'https://image.api.playstation.com/vulcan/ap/rnd/202208/0921/46OCOSLlnvNL5Ari9TUslJ07.jpg',
        totalTrophy: 46,
        goldTrophy: 1,
        silverTrophy: 7,
        bronzeTrophy: 21));

    _gameList.add(RecentlyPlay(
        imageUrl:
            'https://image.api.playstation.com/vulcan/ap/rnd/202203/0903/BRSykxZAAT0OuPrG5nJz19fg.jpg',
        totalTrophy: 41,
        goldTrophy: 1,
        bronzeTrophy: 19));
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
          Container(
            color: Colors.white,
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 65),
                itemCount: _gameList.length,
                itemBuilder: (context, index) {
                  return _buildListItem(index);
                },
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 0,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              opacity: _tabbarOpacity,
              child: PsTabBar(
                tabs: _tabs,
                tabController: _tabController,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('点击'),
              onPressed: () {
                setState(() {
                  _tabbarOpacity = _tabbarOpacity == 0 ? 1.0 : 0;
                });
              },
            ),
          )
        ],
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
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
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
          Column(
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
          )
        ],
      ),
    );
  }
}
