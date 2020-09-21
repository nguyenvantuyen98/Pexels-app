import 'package:equatable/equatable.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';

abstract class MediaListState extends Equatable {
  MediaListState();

  @override
  List<Object> get props => [];
}

class InitialList extends MediaListState {}

class ShowList extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  final int mediaType;
  ShowList({this.photos, this.videos, this.mediaType});
}

class Fetching extends MediaListState {
  Fetching();
}

class FetchingFail extends MediaListState {
  FetchingFail();
}
