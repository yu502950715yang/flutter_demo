import 'package:flutter/material.dart';
import 'package:flutter_demo/common/color/circular_progress_colors.dart';

class CircleProgress extends StatelessWidget {
  const CircleProgress({
    super.key,
    required this.value,
    required this.diameter,
    this.backgroundColor,
  });

  /// 进度
  final double value;

  /// 直径
  final double diameter;

  /// 背景颜色
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    int percentage = (value * 100).toInt();
    final circularProcessColors =
        Theme.of(context).extension<CircularProcessColors>();
    return SizedBox(
      width: diameter,
      height: diameter,
      child: Stack(
        children: [
          SizedBox(
            width: diameter,
            height: diameter,
            child: CircularProgressIndicator(
              value: value,
              backgroundColor:
                  backgroundColor ?? circularProcessColors?.background,
              color: circularProcessColors?.color,
              strokeWidth: 3,
            ),
          ),
          Center(
            child: Text(
              '$percentage%',
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
