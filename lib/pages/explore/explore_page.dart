import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/scroll_configuration/over_scroll_behavior.dart';
import 'package:flutter_demo/view_model/game_news.dart';
import 'package:flutter_demo/widgets/container/ps_container.dart';
import 'package:flutter_demo/widgets/image/net_image.dart';
import 'package:flutter_demo/widgets/tabbar/ps_tabbar.dart';
import 'package:provider/provider.dart';

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
  List<GameNews> _gameNewList = [];

  final double _tabbarOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _initData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initData() {
    _gameNewList = GameNews.mokeData;
  }

  @override
  Widget build(BuildContext context) {
    Color? bgColor = Theme.of(context).colorScheme.primary;
    return SafeArea(
      child: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                color: bgColor,
                child: ScrollConfiguration(
                  behavior: OverScrollBehavior(),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 70),
                    itemCount: _gameNewList.length,
                    itemBuilder: (context, index) {
                      return _buildListItem(index);
                    },
                  ),
                ),
              ),
              Container(
                color: bgColor,
                child: ScrollConfiguration(
                  behavior: OverScrollBehavior(),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 70),
                    itemCount: _gameNewList.length,
                    itemBuilder: (context, index) {
                      return _buildListItem(index);
                    },
                  ),
                ),
              )
            ],
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
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    GameNews gameNews = _gameNewList[index];
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
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: NetImage(url: gameNews.iconUrl!),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameNews.gameName ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      gameNews.timeAgo ?? '',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: () {
                  _showBeLikeSheet(index);
                },
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if (gameNews.videoUrl == null) ...[
            GestureDetector(
              onTap: () {
                print('游戏详情');
              },
              child: Container(
                height: 220,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: NetImage(
                  url: gameNews.imageUrl!,
                ),
              ),
            ),
          ],
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  gameNews.title ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  gameNews.content ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                onPressed: () {
                  print('查看游戏');
                },
                child: const Text('查看游戏'),
              ),
              IconButton(
                  onPressed: () {
                    print('小手');
                  },
                  icon: const ImageIcon(AssetImage('assets/images/likes.png')))
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  void _showBeLikeSheet(int index) {
    GameNews gameNews = _gameNewList[index];
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: gameNews,
          child: Container(
            height: 250,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: NetImage(url: gameNews.iconUrl!),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(gameNews.gameName ?? ''),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              if (gameNews.playPS4) ...[
                                const PsContainer(title: 'PS4'),
                              ],
                              if (gameNews.playPS5) ...[
                                if (gameNews.playPS4) ...[
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                                const PsContainer(title: 'PS5'),
                              ]
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '关注游戏',
                      style: TextStyle(fontSize: 16),
                    ),
                    Consumer<GameNews>(
                      builder: (context, value, child) {
                        return CupertinoSwitch(
                          value: value.interest,
                          onChanged: (value) {
                            Provider.of<GameNews>(context, listen: false)
                                .changeInterest(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: colorScheme.secondaryContainer,
                    minWidth: double.infinity,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('完成'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
