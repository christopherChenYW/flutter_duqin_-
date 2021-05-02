import 'package:flutter/material.dart';
import 'package:flutter_demo/component/error_component.dart';
import 'package:flutter_demo/component/loading_circle.dart';
import 'package:flutter_demo/entity/singer_entity.dart';
import 'package:flutter_demo/service/user_service.dart';
import 'package:flutter_demo/util/util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class SingerPage extends StatefulWidget {
  @override
  _SingerPageState createState() => _SingerPageState();
}

class _SingerPageState extends State<SingerPage> {
  final List<Singer> _singerList = [];
  int _singerCount = 0;
  int page = 1;
  int limit = 10;

  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    _getSingersData();
  }

  _getSingersData() {
    UserService.getUserDataByPage(page: this.page, limit: this.limit)
        .then((value) {
      this.setState(() {
        _singerCount = value.singerCount;

        page++;
        _singerList.addAll(value.singerList);

        if ((page - 1) * limit + 1 > _singerCount)
          _controller.finishLoad(success: true, noMore: true);
        else
          _controller.finishLoad(success: true, noMore: false);
      });
    }).onError((error, stackTrace) {
      this.setState(() {
        errorMsg = error.toString();
      });
    });
  }

  EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    if (errorMsg.length != 0) {
      return FeedBack(
          description: "无法连接到网络",
          onTap: () async {
            this.setState(() {
              errorMsg = "";

              page = 1;
            });
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                _getSingersData();
              }
            });
          });
    } else
      return Stack(children: [
        EasyRefresh(
          header: ClassicalHeader(refreshText: "下拉刷新", refreshingText: "刷新中"),
          footer: ClassicalFooter(noMoreText: "没有更多数据了", loadedText: "加载完成"),
          controller: _controller,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  this.setState(() {
                    _singerList.clear();
                    page = 1;
                    _getSingersData();
                  });
                });
              }
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(seconds: 1), () {
              if (mounted) {
                _getSingersData();
              }
            });
          },
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return _SingerCar(singer: _singerList[index]);
            },
            itemCount: _singerList.length,
          ),
        ),
      ]);
  }
}

class _SingerCar extends StatelessWidget {
  const _SingerCar({
    Key? key,
    required this.singer,
  }) : super(key: key);

  final Singer singer;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(children: [
          Expanded(
            child: Container(
              width: 200,
              height: 200,
              padding: EdgeInsets.only(bottom: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  singer.coverpictureurl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  singer.nickname,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/icons/read.png",
                  width: 20,
                  color: Colors.black,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Text(
                    "歌曲:${singer.musiccount}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Image.asset(
                  "assets/images/icons/read.png",
                  width: 20,
                  color: Colors.black,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Text(
                    "播放:${singer.musicplaycount}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
