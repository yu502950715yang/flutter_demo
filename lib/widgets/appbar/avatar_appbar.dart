import 'package:flutter/material.dart';
import 'package:flutter_demo/view_model/player.dart';

class AvatarAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AvatarAppBar({super.key, required this.player});

  final Player player;

  @override
  State<AvatarAppBar> createState() => _AvatarAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(54);
}

class _AvatarAppBarState extends State<AvatarAppBar> {
  @override
  Widget build(BuildContext context) {
    Color? bgColor = Theme.of(context).appBarTheme.backgroundColor;
    Color? iconColor = Theme.of(context).appBarTheme.iconTheme?.color;

    return Container(
      padding: const EdgeInsets.only(bottom: 4.5),
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 18,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: const Image(
                  image: AssetImage('assets/images/avatar.png'),
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.player.nickName ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                // 下面两行代码取消了点击时的阴影效果
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: iconColor,
                onPressed: () {
                  print('点击通知');
                },
                icon: const Icon(Icons.notifications),
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                color: iconColor,
                onPressed: () {
                  print('点击配置');
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
