import 'package:flutter/material.dart';

class TrophyRow extends StatelessWidget {
  const TrophyRow({
    super.key,
    this.platinumNum = 0,
    this.goldNum = 0,
    this.silverNum = 0,
    this.bronzeNum = 0,
    this.iconSize = const Size(100, 100),
  });

  /// 白金数
  final int? platinumNum;

  /// 黄金数
  final int? goldNum;

  /// 白银数
  final int? silverNum;

  /// 青铜数
  final int? bronzeNum;

  final Size? iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTrophyItem(TrophyType.platinum, platinumNum!),
          const SizedBox(
            width: 20,
          ),
          _buildTrophyItem(TrophyType.gold, goldNum!),
          const SizedBox(
            width: 20,
          ),
          _buildTrophyItem(TrophyType.silver, silverNum!),
          const SizedBox(
            width: 20,
          ),
          _buildTrophyItem(TrophyType.bronze, bronzeNum!),
        ],
      ),
    );
  }

  Widget _buildTrophyItem(TrophyType trophyType, int num) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Image.asset(
            trophyType.imageAssets,
            fit: BoxFit.fill,
          ),
          Text(
            '$num',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

enum TrophyType {
  /// 白金
  platinum(imageAssets: 'assets/images/platinumTrophy.png'),

  /// 黄金
  gold(imageAssets: 'assets/images/goldTrophy.png'),

  /// 白银
  silver(imageAssets: 'assets/images/silverTrophy.png'),

  /// 青铜
  bronze(imageAssets: 'assets/images/bronzeTrophy.png');

  const TrophyType({required this.imageAssets});

  final String imageAssets;
}
