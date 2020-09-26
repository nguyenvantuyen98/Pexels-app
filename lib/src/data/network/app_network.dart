import '../../model/video.dart';
import '../../model/image.dart';
import 'package:dio/dio.dart';

const apiKey1 = '563492ad6f9170000100000156d5de70ea134a2c86369c73c307839c';
const apiKey2 = '563492ad6f917000010000011ccc9cd5a5ba4e709057142305ed8092';
const apiKey3 = '563492ad6f91700001000001c83eda301ea54ebc9021cad92c12bb71';

class AppNetwork {
  static const per_page = 15;
  static const authorization = apiKey1;
  final Dio dio = Dio()..options.headers['Authorization'] = authorization;

  Future<Map<String, dynamic>> _sendRequest(String url) async {
    try {
      var response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Photo>> searchImage(String keyWord, int page) async {
    Map<String, dynamic> data;
    var images = <Photo>[];
    data = await _sendRequest(
        'https://api.pexels.com/v1/search?query=$keyWord&per_page=$per_page&$page');
    for (Map map in data['photos']) {
      images.add(Photo.fromMap(map));
    }
    return images;
  }

  Future<List<Photo>> curatedImage(int page) async {
    Map<String, dynamic> data;
    var images = <Photo>[];
    data = await _sendRequest(
        'https://api.pexels.com/v1/curated?per_page=$per_page&page=$page');
    for (Map map in data['photos']) {
      images.add(Photo.fromMap(map));
    }
    return images;
  }

  Future<List<Video>> searchVideo(String keyWord, int page) async {
    Map<String, dynamic> data;
    var videos = <Video>[];
    data = await _sendRequest(
        'https://api.pexels.com/videos/search?query=$keyWord&per_page=$per_page&page=$page');
    for (Map map in data['videos']) {
      videos.add(Video.fromMap(map));
    }
    return videos;
  }

  Future<List<Video>> popularVideo(int page) async {
    Map<String, dynamic> data;
    var videos = <Video>[];
    data = await _sendRequest(
        'https://api.pexels.com/videos/popular?per_page=$per_page&page=$page');
    for (Map map in data['videos']) {
      videos.add(Video.fromMap(map));
    }
    return videos;
  }

  Future<Photo> getImage(String imageKey) async {
    Map<String, dynamic> data;
    data = await _sendRequest('https://api.pexels.com/v1/photos/$imageKey');
    Photo photo = Photo.fromMap(data);
    return photo;
  }

  Future<Video> getVideo(String videoKey) async {
    Map<String, dynamic> data;
    data = await _sendRequest('https://api.pexels.com/videos/videos/$videoKey');
    Video video = Video.fromMap(data);
    return video;
  }
}

final AppNetwork appNetwork = AppNetwork();
