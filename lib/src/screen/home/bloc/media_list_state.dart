import 'package:equatable/equatable.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';

abstract class MediaListState extends Equatable {
  final int mediaType;
  MediaListState({this.mediaType});

  @override
  List<Object> get props => [];
}

class InitialList extends MediaListState {
  final int mediaType;
  InitialList({this.mediaType}) : super(mediaType: mediaType);
}

class ShowList extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  ShowList({this.photos, this.videos, int mediaType})
      : super(mediaType: mediaType);
}

class Fetching extends MediaListState {
  Fetching(int mediaType) : super(mediaType: mediaType);
}

class FetchingFail extends MediaListState {
  FetchingFail(int mediaType) : super(mediaType: mediaType);
}
