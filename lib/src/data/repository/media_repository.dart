import 'package:app/src/data/database/app_database.dart';
import 'package:app/src/data/network/app_network.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';

class MediaRepository {
  MediaRepository.privateConstructor();

  static final MediaRepository _instance = MediaRepository.privateConstructor();

  factory MediaRepository() {
    return _instance;
  }

  Future<List<Photo>> searchImage(String keyWord, int page) {
    return appNetwork.searchImage(keyWord, page);
  }

  Future<List<Photo>> curatedImage(int page) {
    return appNetwork.curatedImage(page);
  }

  Future<List<Video>> searchVideo(String keyWord, int page) {
    return appNetwork.searchVideo(keyWord, page);
  }

  Future<List<Video>> popularVideo(int page) {
    return appNetwork.popularVideo(page);
  }

  Future<List<Photo>> relatedImage(Photo photo) {
    String keyWord = photo.url;
    if (!keyWord.contains('-')) return appNetwork.curatedImage(1);
    keyWord = keyWord.substring(29, keyWord.lastIndexOf('-'));
    return appNetwork.searchImage(keyWord, 1);
  }

  Future<List<Video>> relatedVideo(Video video) {
    String keyWord = video.url;
    if (!video.url.contains('-')) return appNetwork.popularVideo(1);
    keyWord = keyWord.substring(29, keyWord.lastIndexOf('-'));
    return appNetwork.searchVideo(keyWord, 1);
  }

  Future<List> fetchData({int mediaType, int page, String keyWord}) async {
    if (mediaType == 0 && keyWord != '') {
      return await searchImage(keyWord, page);
    } else if (mediaType == 1 && keyWord != '') {
      return await searchVideo(keyWord, page);
    } else if (mediaType == 0 && keyWord == '') {
      return await curatedImage(page);
    } else if (mediaType == 1 && keyWord == '') {
      return await popularVideo(page);
    } else {
      return [];
    }
  }

  Future<Photo> getImage(String imageKey) {
    return appNetwork.getImage(imageKey);
  }

  Future<Video> getVideo(String videoKey) {
    return appNetwork.getVideo(videoKey);
  }

  Future<void> insert(String id) {
    return appDatabase.insertMediaData(id);
  }

  Future<void> delete(String id) {
    return appDatabase.deleteMediaData(id);
  }

  Future<bool> isContain(String id) {
    return appDatabase.isContain(id);
  }
}
