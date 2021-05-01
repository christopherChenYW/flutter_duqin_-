import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app_colors.dart';
import 'package:flutter_demo/dao/song_dao.dart';
import 'package:flutter_demo/entity/song_entity.dart';
import 'package:flutter_demo/service/song_service.dart';
import 'package:flutter_demo/util/util.dart';

class SongPage extends StatefulWidget {
  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final List<SongItem> _songList = [];
  int page = 1;
  int limit = 10;
  int songCount = 0;
  String errorMsg = "";
  @override
  void initState() {
    super.initState();
    _getSongs();
  }

  _getSongs() {
    try {
      SongService.getSongsDataByPage(page: this.page, limit: this.limit)
          .then((value) {
        this.setState(() {
          page++;
          songCount = value.songCount;
          _songList.addAll(value.list);
        });
      });
    } catch (e) {
      this.setState(() {
        errorMsg = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return SongCard(songItem: _songList[index]);
      },
      itemCount: _songList.length,
    );
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
                style: TextStyle(fontSize: 16, color: AppColors.active),
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
                    margin: EdgeInsets.only(left: 6),
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      songItem.singer.type,
                      style: TextStyle(
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
                "$commentCount",
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
                "$thumbUpCount",
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
                "$readCount",
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
