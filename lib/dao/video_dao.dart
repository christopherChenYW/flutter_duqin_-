import 'package:flutter_demo/config/http/http.dart';

class VideoDao {
  static const String BASEURL = "/flutterapi/video/";

  static Future<dynamic> getVideosByPage(int page, int limit) async {
    Map<String, dynamic> response = await Http.get("${BASEURL}getVideoByPage",
        params: {"page": page, "limit": limit});
    return response;
  }

  static Future<dynamic> getAllAVideos() async {
    Map<String, dynamic> response = await Http.get(
      "${BASEURL}getAllVideos",
    );
    return response;
  }
}
