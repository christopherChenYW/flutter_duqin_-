import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/entity/article_entity.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ArticlePage extends StatefulWidget {
  @override
  ArticlePageState createState() {
    return ArticlePageState();
  }
}

class ArticlePageState extends State<ArticlePage> {
  final List<Article> _articleList = [];
  _getArticleData() {}
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Text(_articleList[index].coverurllist);
            },
            childCount: _articleList.length,
          ),
        ),
      ],
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {}
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {}
        });
      },
    );
  }
}
