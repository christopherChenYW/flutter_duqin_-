import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app_theme.dart';
import 'package:flutter_demo/pages/transit_page.dart';
import 'package:flutter_demo/routes/Routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '读琴',
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: TransitPage(),
    );
  }
}
