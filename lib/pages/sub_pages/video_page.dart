import 'package:flutter/material.dart';
import 'package:flutter_demo/component/comment_and_like_component.dart';
import 'package:flutter_demo/component/error_component.dart';
import 'package:flutter_demo/component/swiper_component.dart';
import 'package:flutter_demo/component/user_type_component.dart';
import 'package:flutter_demo/entity/video_entity.dart';
import 'package:flutter_demo/pages/index_page.dart';
import 'package:flutter_demo/service/video_service.dart';
import 'package:flutter_demo/util/util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final List<Video> _videoList = [];
  int _videoCount = 0;
  int page = 1;
  int limit = 10;
  final List<Widget> swiperList = [];
  String errorMsg = "";

  @override
  void initState() {
    super.initState();
    _getSingersData();
    swiperList.add(Image.network(
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F05.imgmini.eastday.com%2Fmobile%2F20180214%2F20180214110020_8fef153db74bb8696becea858574d33f_1.gif&refer=http%3A%2F%2F05.imgmini.eastday.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1622095542&t=727c58b9745dd445cc49ce5ccbc140f5",
      fit: BoxFit.cover,
    ));
    swiperList.add(Image.network(
      "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=129474270,2801435851&fm=26&gp=0.jpg",
      fit: BoxFit.cover,
    ));
    swiperList.add(Image.network(
      "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2893136577,3651805089&fm=26&gp=0.jpg",
      fit: BoxFit.cover,
    ));
  }

  _getSingersData() {
    VideoService.getSongsDataByPage(page: this.page, limit: this.limit)
        .then((value) {
      this.setState(() {
        _videoCount = value.videoCount;

        page++;
        _videoList.addAll(value.videoList);

        if ((page - 1) * limit + 1 > _videoCount)
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
                    _videoList.clear();
                    page = 1;
                    _getSingersData();
                  });
                  _controller.finishRefresh(success: true, noMore: false);
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
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SwiperComponent(swiperList: swiperList),
            ),
            GridView.count(
              padding: EdgeInsets.all(10),
              //滑动方向
              scrollDirection: Axis.vertical,
              physics: new NeverScrollableScrollPhysics(),
              //水平间隔
              crossAxisSpacing: 5.0,
              //垂直间隔
              mainAxisSpacing: 5.0,
              //一行多少个
              crossAxisCount: 2,
              shrinkWrap: true,
              //宽高比 默认1
              childAspectRatio: 7 / 12,
              children: _videoList.map((item) {
                return VideoCard(
                  videoItem: item,
                );
              }).toList(),
            ),
          ]),
        ),
      ]);
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
    required Video videoItem,
  })  : _videoItem = videoItem,
        super(key: key);

  final Video _videoItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      child: Column(
        children: [
          _VideoImage(videoItem: _videoItem),
          SizedBox(
            height: 10,
          ),
          _UserInfoComponent(videoItem: _videoItem),
          SizedBox(height: 1),
          CommentAndLike(
            commentCount: _videoItem.commentcount,
            thumbUpCount: _videoItem.thumbupcount,
            readCount: _videoItem.readcount,
          )
        ],
      ),
    );
  }
}

class _UserInfoComponent extends StatelessWidget {
  const _UserInfoComponent({
    Key? key,
    required Video videoItem,
  })  : _videoItem = videoItem,
        super(key: key);

  final Video _videoItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
            child: FadeInImage.assetNetwork(
          placeholder: "assets/images/common/lazy-1.png",
          image: _videoItem.usercoverpictureurl,
          fit: BoxFit.cover,
          width: toRpx(30, context),
        )),
        UserTypeConponment(type: _videoItem.type),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            _videoItem.nickname,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _VideoImage extends StatelessWidget {
  const _VideoImage({
    Key? key,
    required Video videoItem,
  })  : _videoItem = videoItem,
        super(key: key);

  final Video _videoItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/videoPlayPage', arguments: _videoItem);
      },
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 0.7,
            child: FadeInImage.assetNetwork(
                placeholder: "assets/images/common/lazy-3.png",
                image: _videoItem.coverpictureurl,
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 80,
          top: 110,
          child: Opacity(
            opacity: 0.7,
            child: Image.asset(
              "assets/images/icons/play_plus.png",
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
        )
      ]),
    );
  }
}
