import 'package:flutter_demo/config/http/http.dart';
import 'package:flutter_demo/entity/song_entity.dart';

class SongDao {
  static Future<List<dynamic>> getSongsByPage(int page, int limit) async =>
      Http.get("/flutterapi/song/selectSongsWithUserByPage",
          params: {"page": page, "limit": limit}).then((value) {
        return value;
      });
  static Future<List<dynamic>> getAllSongs() async => Http.get(
        "/flutterapi/song/selectAllSongsWithoutUser",
      ).then((value) {
        return value;
      });
}
