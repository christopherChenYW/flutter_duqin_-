import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/song_dao.dart';
import 'package:flutter_demo/entity/song_entity.dart';
import 'package:flutter_demo/service/song_service.dart';

class SongPage extends StatefulWidget {
  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  late final List<SongItem> _songList;
  int page = 1;
  int limit = 5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SongService.getSongsDataByPage(page: this.page, limit: this.limit);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        return Text("ff");
      }),
    );
  }
}
