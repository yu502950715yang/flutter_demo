class GameNews {
  /// 图标url
  String? iconUrl;

  /// 新闻title
  String? title;

  /// 时长
  String? timeAgo;

  /// 图片url
  String? imageUrl;

  /// 视频url
  String? videoUrl;

  /// 游戏名
  String? gameName;

  /// 新闻内容
  String? content;

  GameNews({
    this.iconUrl,
    this.title,
    this.timeAgo,
    this.imageUrl,
    this.videoUrl,
    this.gameName,
    this.content,
  });

  static List<GameNews> get mokeData {
    return [
      GameNews(
          gameName: '《刺客信条：维京纪元》',
          iconUrl:
              'https://image.api.playstation.com/vulcan/ap/rnd/202107/2116/MqcP7UprrFnvFlEz4m1DDK6o.png?w=440&thumb=false',
          timeAgo: '19小时前',
          imageUrl:
              'https://image.api.playstation.com/vulcan/ap/rnd/202208/1718/M1M5lbWg6QPwf2gx34N3v78v.jpg?w=440&thumb=false',
          title: 'UBISOFT FORWARD LIVE',
          content:
              '在北京时间6月13日凌晨1点加入我们，共同观看育碧前瞻会最新直播活动，揭秘《The Crew Motorfest》 、《Assassin\'s CreedMirage》、《Avatar: Frontiers of Pandora》等即将上市的育碧游戏大作。'),
      GameNews(
          gameName: 'Grand Theft Auto V (PlayStation5)',
          iconUrl:
              'https://image.api.playstation.com/cdn/UP1004/CUSA00419_00/fd8W1NzjmglT8LxNrKdBE6C4m3PfuHqOcn6E5FRTRhWbfjBfme4WqHqud1iG6PRF.png?w=440&thumb=false',
          timeAgo: '1天前',
          imageUrl:
              'https://image.api.playstation.com/vulcan/ap/rnd/202203/0911/VIB0SeEj9vT6DTv7P4thJLZi.jpg',
          title: '《圣安地列斯雇佣兵》: 6 月 13日',
          content:
              '在 GTA 在线模式: 圣安地列斯雇佣兵中，与精英飞行员和退役军人组成的团队一起行动，与梅利威瑟安保的庞大部队作战，这是一个横跨南圣安地列斯街头、海洋和天空的动感十足的全新更新，于6 月 13 日推出。'),
    ];
  }
}
