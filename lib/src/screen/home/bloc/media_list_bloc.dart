import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/src/data/repository/media_repository.dart';
import '../../../data/repository/media_repository.dart';
import 'media_list_event.dart';
import 'media_list_state.dart';

const photoCode = 0;
const videoCode = 1;

class MediaListBloc extends Bloc<MediaListEvent, MediaListState> {
  MediaRepository mediaRepository = MediaRepository();

  int mediaType = photoCode;
  String keyWord = '';
  List<Photo> photos = [];
  List<Video> videos = [];
  int imagePage = 0;
  int videoPage = 0;

  MediaListBloc() : super(InitialListState());

  @override
  Stream<MediaListState> mapEventToState(MediaListEvent event) async* {
    if (event is FetchDataEvent) {
      yield* _fetchingData(mediaType);
    }
    if (event is MediaTypeChangedEvent) {
      mediaType = event.mediaType;

      yield* _fetchingInitialData(mediaType);
    }
    if (event is SearchSubmitEvent) {
      keyWord = event.keyWord;
      _resetData();

      yield* _fetchingData(mediaType);
    }

    if (event is BackToShowListEvent) {
      keyWord = '';
      _resetData();

      yield* _fetchingData(mediaType);
    }

    if (event is LikedMediaEvent) {
      if (await mediaRepository.isContain(event.media.id)) {
        await mediaRepository.delete(event.media.id);
        print('deleted');
        photos = await checkFavoriteList(photos);
        videos = await checkFavoriteList(videos);
      } else {
        await mediaRepository.insert(event.media.id);
        print('added');
        photos = await checkFavoriteList(photos);
        videos = await checkFavoriteList(videos);
      }
      ShowListState(photos: photos, videos: videos, mediaType: mediaType);
    }
  }

  void _resetData() {
    photos = [];
    videos = [];
    imagePage = 0;
    videoPage = 0;
  }

  Stream<MediaListState> _fetchingData(int mediaType) async* {
    yield FetchingState();

    if (mediaType == photoCode) {
      List<Photo> nextPhotos;
      try {
        nextPhotos = await mediaRepository.fetchData(
            mediaType: photoCode, page: imagePage + 1, keyWord: keyWord);
      } catch (e) {
        yield FetchingFailState();
        return;
      }
      if (nextPhotos.isEmpty) {
        yield ShowListState(
            photos: photos,
            videos: videos,
            mediaType: mediaType,
            reachedMax: true);
      } else {
        photos.addAll(nextPhotos);
        imagePage += 1;
        print('photos.length = ${photos.length}');
        photos = await checkFavoriteList(photos);
        yield ShowListState(
            photos: photos, videos: videos, mediaType: mediaType);
      }
    } else {
      List<Video> nextVideos;
      try {
        nextVideos = await mediaRepository.fetchData(
            mediaType: videoCode, page: videoPage + 1, keyWord: keyWord);
      } catch (e) {
        yield FetchingFailState();
        return;
      }
      if (nextVideos.isEmpty) {
        yield ShowListState(
            photos: photos,
            videos: videos,
            mediaType: mediaType,
            reachedMax: true);
      } else {
        videos.addAll(nextVideos);
        videoPage += 1;
        print('videos.length = ${videos.length}');
        videos = await checkFavoriteList(videos);
        yield ShowListState(
            photos: photos, videos: videos, mediaType: mediaType);
      }
    }
  }

  Stream<MediaListState> _fetchingInitialData(int mediaType) async* {
    if (mediaType == photoCode) {
      if (photos.isEmpty) {
        yield FetchingState();
        List<Photo> nextPhotos;
        try {
          nextPhotos += await mediaRepository.fetchData(
              mediaType: photoCode, page: imagePage + 1, keyWord: keyWord);
        } catch (e) {
          yield FetchingFailState();
          return;
        }
        if (nextPhotos.isEmpty) {
          yield NoMatchingResultState();
        } else {
          photos.addAll(nextPhotos);
          imagePage += 1;
          print('photos.length = ${photos.length}');
          photos = await checkFavoriteList(photos);
          yield ShowListState(
              photos: photos, videos: videos, mediaType: mediaType);
        }
      }
    } else {
      if (videos.isEmpty) {
        yield FetchingState();
        List<Video> nextVideos;
        try {
          nextVideos = await mediaRepository.fetchData(
              mediaType: videoCode, page: videoPage + 1, keyWord: keyWord);
        } catch (e) {
          yield FetchingFailState();
          return;
        }
        if (nextVideos.isEmpty) {
          yield NoMatchingResultState();
        } else {
          videos.addAll(nextVideos);
          videoPage += 1;
          print('videos.length = ${videos.length}');
          videos = await checkFavoriteList(videos);
          yield ShowListState(
              photos: photos, videos: videos, mediaType: mediaType);
        }
      }
    }
  }

  Future<List> checkFavoriteList(List mediaList) async {
    for (int i = 0; i < mediaList.length; i++) {
      mediaList[i].liked = await mediaRepository.isContain(mediaList[i].id);
    }
    return mediaList;
  }
}
