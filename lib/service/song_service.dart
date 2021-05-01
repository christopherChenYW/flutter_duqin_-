import 'package:flutter_demo/dao/song_dao.dart';
import 'package:flutter_demo/entity/song_entity.dart';

class SongService {
  static Future<SongList> getSongsDataByPage(
      {int page = 1, int limit = 5}) async {
    Map response = await SongDao.getSongsByPage(page, limit);

    return SongList.fromJson(response['data'], response['count']);
  }

  static Future<SongList> getAllSongs() async {
    Map response = await SongDao.getAllSongs();
    return SongList.fromJson(response['data'], response['count']);
  }
}
