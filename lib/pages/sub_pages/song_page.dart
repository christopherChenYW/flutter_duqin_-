import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_demo/component/error_component.dart';
import 'package:flutter_demo/component/loading_circle.dart';
import 'package:flutter_demo/config/app_colors.dart';
import 'package:flutter_demo/entity/song_entity.dart';
import 'package:flutter_demo/service/song_service.dart';
import 'package:flutter_demo/util/util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SongPage extends StatefulWidget {
  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> with TickerProviderStateMixin {
  final List<SongItem> _songList = [];
  int page = 1;
  int limit = 15;
  int songCount = 0;
  bool hasError = false;
  String errorMsg = "";
  bool visible = true;
  @override
  void initState() {
    super.initState();
    _getSongs();
  }

  _getSongs() {
    SongService.getSongsDataByPage(page: this.page, limit: this.limit)
        .then((value) {
      this.setState(() {
        errorMsg = "";
        page++;
        songCount = value.songCount;
        _songList.addAll(value.list);
        visible = false;

        if ((page - 1) * limit + 1 > songCount)
          _controller.finishLoad(success: true, noMore: true);
        else
          _controller.finishLoad(success: true, noMore: false);
      });
    }).onError((error, stackTrace) {
      this.setState(() {
        visible = false;
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
              visible = true;
              page = 1;
            });
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                _getSongs();
              }
            });
          });
    } else
      return Stack(children: [
        EasyRefresh.custom(
          controller: _controller,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          header: ClassicalHeader(
              refreshText: "下拉刷新",
              refreshingText: "刷新中",
              refreshedText: "刷新完成"),
          footer: ClassicalFooter(noMoreText: "没有更多数据了", loadedText: "加载完成"),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return SongCard(songItem: _songList[index]);
              }, childCount: _songList.length),
            ),
          ],
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  this.setState(() {
                    _songList.clear();
                    page = 1;
                    _getSongs();
                    _controller.finishRefresh(success: true, noMore: false);
                  });
                });
              }
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(microseconds: 500), () {
              if (mounted) {
                _getSongs();
              }
            });
          },
        ),
        LoadingCircle(
          visible: visible,
        )
      ]);
  }
}

class SongCard extends StatelessWidget {
  const SongCard({Key? key, required this.songItem}) : super(key: key);
  final SongItem songItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          top: toRpx(20.0, context),
          bottom: toRpx(15.0, context),
          right: toRpx(10.0, context)),
      margin: EdgeInsets.all(toRpx(10.0, context)),
      child: Row(
        children: [
          _SongCover(songItem: songItem),
          _SongTitle(songItem: songItem),
        ],
      ),
    );
  }
}

//歌曲名称组件
class _SongTitle extends StatelessWidget {
  const _SongTitle({
    Key? key,
    required this.songItem,
  }) : super(key: key);

  final SongItem songItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: Container(
          padding: EdgeInsets.only(
              left: toRpx(10, context),
              top: toRpx(1, context),
              bottom: toRpx(5, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songItem.cnname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColors.active),
              ),
              Text(
                songItem.enname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, color: AppColors.un3active),
              ),
              Expanded(
                child: Text(""),
              ),
              Row(
                children: [
                  ClipOval(
                      child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/common/lazy-1.png",
                    image: songItem.singer.coverpictureurl,
                    fit: BoxFit.cover,
                    width: toRpx(30, context),
                  )),
                  Container(
                    margin: EdgeInsets.only(left: 3),
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    decoration: BoxDecoration(
                        color: colorMap[songItem.singer.type] ?? Colors.green,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      enMap[songItem.singer.type] ?? '未知用户',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SizedBox(
                      width: toRpx(50, context),
                      child: Text(
                        songItem.singer.nickname,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  _CommentAndLike(
                    commentCount: songItem.commentcount,
                    thumbUpCount: songItem.thumbupcount,
                    readCount: songItem.readcount,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentAndLike extends StatelessWidget {
  final int commentCount;
  final int thumbUpCount;
  final int readCount;
  const _CommentAndLike({
    Key? key,
    this.commentCount = 0,
    this.thumbUpCount = 0,
    this.readCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        Expanded(
            child: Row(
          children: [
            Image.asset(
              "assets/images/icons/comment.png",
              width: 20,
              color: Colors.black,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                Util.strCount(commentCount),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Image.asset(
              "assets/images/icons/like.png",
              width: 20,
              color: Colors.black,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Text(
                Util.strCount(thumbUpCount),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        Expanded(
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
                Util.strCount(readCount),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
      ],
    ));
  }
}

//封面
class _SongCover extends StatelessWidget {
  const _SongCover({
    Key? key,
    required this.songItem,
  }) : super(key: key);

  final SongItem songItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: toRpx(100, context),
      height: toRpx(100, context),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(toRpx(20, context))),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/common/lazy-1.png',
              image: this.songItem.coverpictureurl,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                "assets/images/icons/play_plus.png",
                width: toRpx(20, context),
                height: toRpx(20, context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
