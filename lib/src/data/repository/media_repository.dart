import 'package:app/src/data/network/app_network.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';

enum MediaType { image, video }

class MediaRepository {
  MediaRepository.privateConstructor();

  static final MediaRepository _instance = MediaRepository.privateConstructor();

  factory MediaRepository() {
    return _instance;
  }

  Future<List<Photo>> searchImage(String keyWord, int page) {
    return appNetwork.searchImage(keyWord, page);
  }

  Future<List<Photo>> curatedImage(int page) async {
    return appNetwork.curatedImage(page);
  }

  Future<List<Video>> searchVideo(String keyWord, int page) async {
    return appNetwork.searchVideo(keyWord, page);
  }

  Future<List<Video>> popularVideo(int page) async {
    return appNetwork.popularVideo(page);
  }

  Future<List> fetchData(MediaType status, int page, String keyWord) async {
    if (status == MediaType.image && keyWord != '') {
      return await searchImage(keyWord, page);
    } else if (status == MediaType.video && keyWord != '') {
      return await searchVideo(keyWord, page);
    } else if (status == MediaType.image && keyWord == '') {
      return await curatedImage(page);
    } else if (status == MediaType.video && keyWord == '') {
      return await popularVideo(page);
    } else {
      return [];
    }
  }
}
