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

  Future<List> fetchData({int mediaType, int page, String keyWord}) async {
    // print('fetchedData $mediaType, $page, $keyWord');
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
}
