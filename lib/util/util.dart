import 'package:flutter/material.dart';
import 'package:flutter_demo/config/app_colors.dart';

double toRpx(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.width / 428.0;
}

const Map enMap = {
  'NORMAL_USER': '普通用户',
  'DQ_SINGER': '读琴歌手',
  'DQ_OFFICIAL_ACCOUNT': '读琴号',
  'ADMIN': '管理员'
};

const Map colorMap = {
  'NORMAL_USER': AppColors.unactive,
  'DQ_SINGER': AppColors.info,
  'DQ_OFFICIAL_ACCOUNT': AppColors.success,
  'ADMIN': AppColors.danger,
};

class Util {
  static String strCount(int count) {
    if (count <= 0 || count.isNaN) return '0';
    String result = count.toString();
    if (result.length >= 5) {
      if (result.length >= 9)
        return result.substring(0, result.length - 8) + "亿";
      else
        return result.substring(0, result.length - 4) + "万";
    } else {
      return result;
    }
  }
}
