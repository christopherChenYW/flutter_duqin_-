import 'package:flutter_demo/dao/song_dao.dart';
import 'package:flutter_demo/entity/song_entity.dart';

class SongService {
  static Future<List<dynamic>> getSongsDataByPage(
      {int page = 1, int limit = 5}) async {
    return SongDao.getSongsByPage(page, limit);
  }

  static Future<List<dynamic>> getAllSongs() async {
    return SongDao.getAllSongs();
  }
}
