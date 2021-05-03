import 'package:flutter_demo/dao/song_dao.dart';
import 'package:flutter_demo/dao/video_dao.dart';

import 'package:flutter_demo/entity/video_entity.dart';

class VideoService {
  static Future<VideoList> getSongsDataByPage(
      {int page = 1, int limit = 5}) async {
    Map response = await VideoDao.getVideosByPage(page, limit);
    return VideoList.fromJson(response['data'], response['count']);
  }

  static Future<VideoList> getAllSongs() async {
    Map response = await VideoDao.getAllAVideos();
    return VideoList.fromJson(response['data'], response['count']);
  }
}
