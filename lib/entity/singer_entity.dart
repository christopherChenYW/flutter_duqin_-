class Singer {
  final int id;
  final String coverpictureurl;
  final String nickname;
  final String type;
  final int musiccount;
  final int musicplaycount;
  final String gctime;
  final String gmtime;
  final int version;
  final int deleted;

  Singer(
      {required this.id,
      required this.coverpictureurl,
      required this.nickname,
      required this.type,
      required this.musiccount,
      required this.musicplaycount,
      required this.gctime,
      required this.gmtime,
      required this.version,
      required this.deleted});

  factory Singer.fromJson(dynamic item) {
    return Singer(
        id: item['userid'] ?? item["id"],
        coverpictureurl: item['coverpictureurl'],
        nickname: item['nickname'],
        type: item['type'],
        musiccount: item['musiccount'],
        musicplaycount: item['musicplaycount'],
        gctime: item['gctime'],
        gmtime: item['gmtime'],
        version: item['version'],
        deleted: item['deleted']);
  }
}

class SingerList {
  final List<Singer> singerList;
  final int singerCount;
  SingerList(this.singerList, this.singerCount);
  factory SingerList.fromJson({required List<dynamic> data, int count = 0}) {
    return SingerList(data.map((e) => Singer.fromJson(e)).toList(), count);
  }
}
