import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/index_page.dart';
import 'package:flutter_demo/pages/sub_pages/tiny_video_page.dart';
import 'package:flutter_demo/pages/video_play_page.dart';

// ignore: slash_for_doc_comments
/**
 * 配置路由的地方
 */
final routes = {
  '/index': (context, {arguments}) => IndexPage(
        initIndex: arguments['initIndex'],
        arguments: arguments,
      ),
  '/tinyVideoPlay': (context, {arguments}) =>
      TinyVideoPage(arguments: arguments),
  '/videoPlayPage': (context, {arguments}) => VideoPlayPage(video: arguments),
};

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else
    return null;
}
