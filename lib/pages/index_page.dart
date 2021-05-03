import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app_colors.dart';
import 'package:flutter_demo/pages/sub_pages/home_page.dart';
import 'package:flutter_demo/pages/sub_pages/music_page.dart';
import 'package:flutter_demo/pages/sub_pages/profile_page.dart';
import 'package:flutter_demo/pages/sub_pages/tiny_video_page.dart';

class IndexPage extends StatefulWidget {
  final initIndex;
  final Map? arguments;
  IndexPage({Key? key, this.initIndex = 0, this.arguments}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late int _currntIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItemList = [];
  final Map<String, String> _bottomNames = {
    'home': "首页",
    "music": "音乐",
    "create_media": "",
    "tiny_video": "小视频",
    "profile": "我的"
  };
  final List _pageList = [
    HomePage(),
    MusicPage(),
    HomePage(),
    TinyVideoPage(),
    ProfilePage()
  ];
  @override
  void initState() {
    super.initState();
    _currntIndex = widget.initIndex;

    _bottomNames.forEach((key, value) {
      _bottomNavBarItemList.add(_bottomNavBarItem(key, value));
    });
  }

  BottomNavigationBarItem _bottomNavBarItem(String key, String value) {
    if (key == "create_media")
      return BottomNavigationBarItem(
        activeIcon: Image.asset("assets/images/icons/${key}_active.png",
            width: 50, height: 50, fit: BoxFit.cover),
        label: "$value",
        backgroundColor: AppColors.nav,
        tooltip: "发布",
        icon: Image.asset(
          "assets/images/icons/$key.png",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      );

    return BottomNavigationBarItem(
      activeIcon: Image.asset("assets/images/icons/${key}_active.png",
          width: 24, height: 24, fit: BoxFit.cover),
      label: "$value",
      icon: Image.asset("assets/images/icons/$key.png",
          width: 24, height: 24, fit: BoxFit.cover),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavBarItemList,
        currentIndex: _currntIndex,
        onTap: _onTabClick,
      ),
      body: _pageList[_currntIndex],
    );
  }

  void _onTabClick(int value) {
    this.setState(() {
      this._currntIndex = value;
    });
  }
}
