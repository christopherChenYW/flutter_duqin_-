import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/component/comment_and_like_component.dart';
import 'package:flutter_demo/component/error_component.dart';
import 'package:flutter_demo/component/loading_circle.dart';
import 'package:flutter_demo/component/user_type_component.dart';
import 'package:flutter_demo/config/app_colors.dart';
import 'package:flutter_demo/entity/article_entity.dart';
import 'package:flutter_demo/service/article_service.dart';
import 'package:flutter_demo/util/util.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ArticlePage extends StatefulWidget {
  @override
  ArticlePageState createState() {
    return ArticlePageState();
  }
}

class ArticlePageState extends State<ArticlePage> {
  final List<Article> _articleList = [];
  int page = 1;
  int limit = 5;
  int articleCount = 0;
  bool hasError = false;
  String errorMsg = "";
  bool visible = true;
  EasyRefreshController _controller = EasyRefreshController();
  _getArticleData() {
    ArticleService.getUserDataByPage(page: this.page, limit: this.limit)
        .then((value) {
      this.setState(() {
        errorMsg = "";
        page++;
        articleCount = value.articleCount;
        _articleList.addAll(value.articleList);
        visible = false;
        if ((page - 1) * limit + 1 > articleCount)
          _controller.finishLoad(success: true, noMore: true);
        else
          _controller.finishLoad(success: true, noMore: false);
      });
    }).onError((error, stackTrace) {
      this.setState(() {
        visible = false;
        errorMsg = error.toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getArticleData();
  }

  @override
  Widget build(BuildContext context) {
    if (errorMsg.length != 0) {
      return FeedBack(
          description: "无法连接到网络",
          onTap: () async {
            this.setState(() {
              errorMsg = "";
              visible = true;
              page = 1;
            });
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                _getArticleData();
              }
            });
          });
    } else
      return Stack(children: [
        EasyRefresh.custom(
          controller: _controller,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          header: ClassicalHeader(
              refreshText: "下拉刷新",
              refreshingText: "刷新中",
              refreshedText: "刷新完成"),
          footer: ClassicalFooter(noMoreText: "没有更多数据了", loadedText: "加载完成"),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ArticleCard(articleItem: _articleList[index]);
              }, childCount: _articleList.length),
            ),
          ],
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  this.setState(() {
                    _articleList.clear();
                    page = 1;
                    _getArticleData();
                  });
                });
                _controller.finishRefresh(success: true, noMore: false);
              }
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(microseconds: 500), () {
              if (mounted) {
                _getArticleData();
              }
            });
          },
        ),
        LoadingCircle(
          visible: visible,
        )
      ]);
  }
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required Article articleItem,
  })  : _articleItem = articleItem,
        super(key: key);

  final Article _articleItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ArticleImageCard(articleItem: _articleItem),
          ListTile(
            title: Text(_articleItem.title),
            subtitle: Row(
              children: [
                UserTypeConponment(
                  type: _articleItem.type,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 20),
                  child: Text(
                    _articleItem.nickname,
                    style: TextStyle(color: AppColors.active),
                  ),
                ),
                CommentAndLike(
                  commentCount: _articleItem.commentcount,
                  thumbUpCount: _articleItem.thumbupcount,
                  readCount: _articleItem.readcount,
                ),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_articleItem.usercoverpictureurl),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleImageCard extends StatelessWidget {
  const ArticleImageCard({
    Key? key,
    required Article articleItem,
  })  : _articleItem = articleItem,
        super(key: key);

  final Article _articleItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "${_articleItem.coverurllist[0]}",
              height: 305,
              fit: BoxFit.cover,
            ),
          ),
          flex: 2,
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "${_articleItem.coverurllist[1]}",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "${_articleItem.coverurllist[2]}",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
