import 'package:flutter/material.dart';
import 'package:flutter_demo/common/color/container_colors.dart';

class PlayHomeSkeleton extends StatelessWidget {
  const PlayHomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildListItem(context),
          _buildListItem(context),
          _buildListItem(context),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    final containerColors = Theme.of(context).extension<ContainerColors>();
    Color? bgColor = containerColors?.background;
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
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 190,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 18,
            width: double.infinity,
            color: bgColor,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: bgColor,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            color: bgColor,
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
