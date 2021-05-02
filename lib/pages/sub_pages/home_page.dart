import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app_colors.dart';
import 'package:flutter_demo/pages/sub_pages/singer_page.dart';

import 'package:flutter_demo/pages/sub_pages/song_page.dart';

import 'article_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> _tabs = [
    Tab(
      text: '推荐',
    ),
    Tab(
      text: '歌曲',
    ),
    Tab(
      text: '歌手',
    ),
    Tab(
      text: '文章',
    ),
    Tab(
      text: '视频',
    )
  ];

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  List<Widget> _tabContent = [
    Text("1"),
    SongPage(),
    SingerPage(),
    ArticlePage(),
    Text("1")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _HomePageHeader(),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          // // isScrollable: true,
          // indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
      body: TabBarView(
        children: _tabContent,
        controller: _tabController,
      ),
    );
  }
}

class _HomePageHeader extends StatelessWidget {
  const _HomePageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 80,
          child: Image.asset(
            "assets/images/common/logo.png",
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 10.0),
                    child: Icon(
                      Icons.search,
                      color: AppColors.un3active,
                      size: 25,
                    ),
                  ),
                  Expanded(
                      child: Center(
                    heightFactor: 0.5,
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(right: 10),
                      child: TextField(
                        cursorColor: Colors.grey,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "搜索关键词",
                            focusColor: Colors.white),
                        maxLines: 1,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 40,
          child: Image.asset(
            "assets/images/icons/msg.png",
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }
}
