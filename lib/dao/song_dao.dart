import 'package:flutter_demo/config/http/http.dart';

class SongDao {
  static const String BASEURL = "/flutterapi/song/";

  static Future<dynamic> getSongsByPage(int page, int limit) async {
    Map<String, dynamic> response = await Http.get(
        "${BASEURL}selectSongsWithUserByPage",
        params: {"page": page, "limit": limit});
    return response;
  }

  static Future<dynamic> getAllSongs() async {
    Map<String, dynamic> response = await Http.get(
      "${BASEURL}selectAllSongsWithoutUser",
    );
    return response;
  }
}
