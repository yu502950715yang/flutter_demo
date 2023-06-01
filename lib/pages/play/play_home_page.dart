import 'package:flutter/material.dart';

class PlayHomePage extends StatefulWidget {
  const PlayHomePage({super.key});

  @override
  State<PlayHomePage> createState() => _PlayHomePageState();
}

class _PlayHomePageState extends State<PlayHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
