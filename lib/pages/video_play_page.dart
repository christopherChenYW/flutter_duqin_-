import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/video_entity.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPage extends StatefulWidget {
  final Video video;
  const VideoPlayPage({Key? key, required this.video}) : super(key: key);
  @override
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage>
    with TickerProviderStateMixin {
  late final VideoPlayerController _controller;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.videourl)
      ..initialize().then((_) {
        this.setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: _controller.value.isInitialized
          ? ListView(children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: InkWell(
                    onTap: () {
                      this.setState(() {
                        isPlaying = !isPlaying;
                      });
                      if (isPlaying)
                        _controller.play();
                      else
                        _controller.pause();
                    },
                    child: VideoPlayComponent(
                        controller: _controller, isPlaying: isPlaying),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 150,
                    child: TabBar(
                      unselectedLabelStyle: TextStyle(fontSize: 15),
                      labelStyle: TextStyle(fontSize: 15),
                      labelColor: Colors.pink,
                      tabs: [
                        Tab(
                          text: '推荐',
                        ),
                        Tab(
                          text: '歌曲',
                        ),
                      ],
                      controller: TabController(
                        length: 2,
                        initialIndex: 0,
                        vsync: this,
                      ),
                    ),
                  ),
                  Expanded(child: Text("")),
                  Container(
                    height: 35,
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onChanged: (value) {},
                      //这是一个文本框
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.translate_sharp,
                            color: Colors.blue,
                          ),
                          labelText: '点我发弹幕',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                  ),
                ],
              )
            ])
          : _LoadVideoFailWidget(),
    );
  }
}

class VideoPlayComponent extends StatelessWidget {
  const VideoPlayComponent({
    Key? key,
    required VideoPlayerController controller,
    required this.isPlaying,
  })  : _controller = controller,
        super(key: key);

  final VideoPlayerController _controller;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      VideoPlayer(_controller),
      Align(
        alignment: Alignment.center,
        child: !isPlaying
            ? Opacity(
                opacity: 0.6,
                child: Icon(
                  Icons.play_arrow,
                  size: 40,
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
    ]);
  }
}

class _LoadVideoFailWidget extends StatelessWidget {
  const _LoadVideoFailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
