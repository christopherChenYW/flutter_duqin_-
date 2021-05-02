import 'package:flutter_demo/config/http/http.dart';

class UserDao {
  static const String BASEURL = "/flutterapi/user/";

  static Future<dynamic> getUsersByPage(int page, int limit) async {
    Map<String, dynamic> response = await Http.get("${BASEURL}getUserByPage",
        params: {"page": page, "limit": limit});
    return response;
  }

  static Future<dynamic> getAllUser() async {
    Map<String, dynamic> response = await Http.get(
      "${BASEURL}getAllUsers",
    );
    return response;
  }
}
