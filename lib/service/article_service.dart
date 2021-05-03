import 'package:flutter_demo/dao/article_dao.dart';
import 'package:flutter_demo/entity/article_entity.dart';

class ArticleService {
  static Future<ArticleList> getUserDataByPage(
      {int page = 1, int limit = 15}) async {
    Map response = await ArticleDao.getArticleByPage(page, limit);
    return ArticleList.fromJson(
        data: response['data'], count: response['count']);
  }

  static Future<ArticleList> getAllUsers() async {
    Map response = await ArticleDao.getAllArticles();
    return ArticleList.fromJson(
        data: response['data'], count: response['count']);
  }
}
