class Article {
  final int id;

  final int userid;

  final List<String> coverurllist;

  final String title;

  final int commentcount;

  final int thumbupcount;

  final int readcount;

  final String nickname;
  final String usercoverpictureurl;
  final String type;

  Article(
      {required this.nickname,
      required this.usercoverpictureurl,
      required this.type,
      required this.id,
      required this.userid,
      required this.coverurllist,
      required this.title,
      required this.commentcount,
      required this.thumbupcount,
      required this.readcount});

  factory Article.fromJson(dynamic item) {
    List<String> urlList = item['coverurllist'].toString().split(",");
    return Article(
        id: item['id'],
        userid: item['userid'],
        coverurllist: urlList,
        title: item['title'],
        commentcount: item['commentcount'],
        thumbupcount: item['thumbupcount'],
        readcount: item['readcount'],
        nickname: item['nickname'],
        type: item['type'],
        usercoverpictureurl: item['usercoverpictureurl']);
  }
}

class ArticleList {
  final List<Article> articleList;
  final int articleCount;

  factory ArticleList.fromJson({required List<dynamic> data, int count = 0}) {
    return ArticleList(data.map((e) => Article.fromJson(e)).toList(), count);
  }

  ArticleList(this.articleList, this.articleCount);
}
