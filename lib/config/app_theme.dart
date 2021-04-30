import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app_colors.dart';

final ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.page,
    primaryColor: AppColors.primary,
    splashColor: Colors.transparent, //取消水波纹效果
    textTheme: TextTheme(bodyText2: TextStyle(color: AppColors.unactive)),
    indicatorColor: AppColors.active,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.nav, elevation: 0),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: AppColors.unactive,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(fontSize: 18),
      labelPadding: EdgeInsets.symmetric(horizontal: 12),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.nav,
        selectedItemColor: AppColors.active,
        unselectedItemColor: AppColors.unactive,
        selectedLabelStyle: TextStyle(fontSize: 15)));
