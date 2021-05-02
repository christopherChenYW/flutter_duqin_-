import 'package:flutter_demo/config/http/http.dart';

class ArticleDao {
  static const String BASEURL = "/flutterapi/article/";

  static Future<dynamic> getArticleByPage(int page, int limit) async {
    Map<String, dynamic> response = await Http.get(
        "${BASEURL}selectSongsWithUserByPage",
        params: {"page": page, "limit": limit});
    return response;
  }

  static Future<dynamic> getAllArticles() async {
    Map<String, dynamic> response = await Http.get(
      "${BASEURL}selectAllSongsWithoutUser",
    );
    return response;
  }
}
