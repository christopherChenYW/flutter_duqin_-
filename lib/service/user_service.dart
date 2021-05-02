import 'package:flutter_demo/dao/user_dao.dart';
import 'package:flutter_demo/entity/singer_entity.dart';

class UserService {
  static Future<SingerList> getUserDataByPage(
      {int page = 1, int limit = 15}) async {
    Map response = await UserDao.getUsersByPage(page, limit);
    return SingerList.fromJson(
        data: response['data'], count: response['count']);
  }

  static Future<SingerList> getAllUsers() async {
    Map response = await UserDao.getAllUser();
    return SingerList.fromJson(
        data: response['data'], count: response['count']);
  }
}
