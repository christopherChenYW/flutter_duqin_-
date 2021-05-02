class Article {
  final int id;

  final int userid;

  final String coverurllist;

  final String title;

  final int commentcount;

  final int thumbupcount;

  final int readcount;

  Article(
      {required this.id,
      required this.userid,
      required this.coverurllist,
      required this.title,
      required this.commentcount,
      required this.thumbupcount,
      required this.readcount});

  factory Article.fromJson(dynamic item) {
    return Article(
        id: item['id'],
        userid: item['userid'],
        coverurllist: item['coverurllist'],
        title: item['title'],
        commentcount: item['commentcount'],
        thumbupcount: item['thumbupcount'],
        readcount: item['readcount']);
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
