import 'package:flutter/material.dart';
import 'package:flutter_demo/common/color/container_colors.dart';

class PsContainer extends StatelessWidget {
  final String title;

  const PsContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final containerColors = Theme.of(context).extension<ContainerColors>();
    return SizedBox(
      width: 30,
      height: 20,
      child: Container(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: containerColors!.deepBackground,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: containerColors.deepBackgroundText,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
