class RecentlyPlay {
  /// 游戏图片地址
  String imageUrl;

  /// 游戏总奖杯数
  int totalTrophy;

  /// 白金奖杯数
  int? platinumTrophy;

  /// 黄金奖杯
  int? goldTrophy;

  /// 白银奖杯
  int? silverTrophy;

  /// 青铜奖杯
  int? bronzeTrophy;

  RecentlyPlay({
    required this.imageUrl,
    required this.totalTrophy,
    this.platinumTrophy = 0,
    this.goldTrophy = 0,
    this.silverTrophy = 0,
    this.bronzeTrophy = 0,
  });
}
