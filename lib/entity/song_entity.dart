import 'package:flutter_demo/entity/singer_entity.dart';

class SongItem {
  final int id;
  final int userid;
  final String coverpictureurl;
  final String songurl;
  final String cnname;
  final String enname;
  final int commentcount;
  final int thumbupcount;
  final int readcount;
  final Singer singer;
  SongItem(
      {required this.id,
      required this.userid,
      required this.coverpictureurl,
      required this.songurl,
      required this.cnname,
      required this.enname,
      required this.commentcount,
      required this.thumbupcount,
      required this.readcount,
      required this.singer});

  factory SongItem.fromJson(dynamic item) => SongItem(
      id: item['id'],
      userid: item['userid'],
      coverpictureurl: item['coverpictureurl'],
      songurl: item['songurl'],
      cnname: item['cnname'],
      enname: item['enname'],
      commentcount: item['commentcount'],
      thumbupcount: item['thumbupcount'],
      readcount: item['readcount'],
      singer: Singer.fromJson(item));
}

//歌曲详情页数据
class SongList {
  final List<SongItem> list;

  SongList(this.list);

  factory SongList.fromJson(List<dynamic> jsonList) {
    return SongList(jsonList.map((e) => SongItem.fromJson(e)).toList());
  }
}
