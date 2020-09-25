import 'package:equatable/equatable.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';

abstract class MediaListState extends Equatable {
  MediaListState();

  @override
  List<Object> get props => [];
}

class InitialListState extends MediaListState {}

class ShowListState extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  final int mediaType;
  final bool reachedMax;
  ShowListState(
      {this.photos, this.videos, this.mediaType, this.reachedMax = false});
}

class FetchingState extends MediaListState {
  FetchingState();
}

class FetchingFailState extends MediaListState {
  FetchingFailState();
}

class NoMatchingResultState extends MediaListState {
  NoMatchingResultState();
}
