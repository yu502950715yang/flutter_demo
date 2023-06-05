import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/tabbar/cupertino_tab_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: CupertinoTabBar(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.pink,
              widgets: const [
                Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Play",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Share",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.75,
                    fontWeight: FontWeight.w400,
                    fontFamily: "SFProRounded",
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              valueGetter: _valueGetter,
              onTap: _onTap,
              useShadow: false,
              allowScrollable: true,
              fittedWhenScrollable: true
              // innerHorizontalPadding: 5,
              ),
        ),
      ),
    );
  }

  int _valueGetter() {
    return _currentIndex;
  }

  void _onTap(int index) {
    _currentIndex = index;
    setState(() {});
  }
}
