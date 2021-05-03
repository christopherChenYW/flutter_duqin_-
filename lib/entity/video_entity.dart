class Video {
  final int id;

  final int userid;

  final String coverpictureurl;

  final String videourl;

  final String title;

  final String intro;

  final int commentcount;

  final int thumbupcount;

  final int readcount;

  final int sharecount;

  final int contentseconds;

  final String nickname;
  final String type;
  final String usercoverpictureurl;
  Video(
      this.id,
      this.userid,
      this.coverpictureurl,
      this.videourl,
      this.title,
      this.intro,
      this.commentcount,
      this.thumbupcount,
      this.readcount,
      this.sharecount,
      this.contentseconds,
      this.nickname,
      this.type,
      this.usercoverpictureurl);

  factory Video.fromJson(dynamic item) {
    return Video(
        item['id'],
        item['userid'],
        item['coverpictureurl'],
        item['videourl'],
        item['title'],
        item['intro'],
        item['commentcount'],
        item['thumbupcount'],
        item['readcount'],
        item['sharecount'],
        item['contentseconds'],
        item['nickname'],
        item['type'],
        item['usercoverpictureurl']);
  }
}

//歌曲详情页数据
class VideoList {
  final List<Video> videoList;
  final int videoCount;

  factory VideoList.fromJson(List<dynamic> jsonList, int videoCount) {
    return VideoList(
        jsonList.map((e) => Video.fromJson(e)).toList(), videoCount);
  }

  VideoList(this.videoList, this.videoCount);
}
