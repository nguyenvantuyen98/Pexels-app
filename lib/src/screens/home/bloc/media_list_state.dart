import 'package:app/src/model/image.dart';
import 'package:app/src/model/video.dart';
import 'package:equatable/equatable.dart';

abstract class MediaListState extends Equatable {
  const MediaListState();

  @override
  List<Object> get props => [];
}

class MediaListInitialState extends MediaListState {}

class MediaListFailureState extends MediaListState {}

class MediaListSuccessState extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  final bool hasReachedMax;

  const MediaListSuccessState({this.photos, this.videos, this.hasReachedMax});

  MediaListSuccessState copyWith({List<Photo> photos, List<Video> videos, bool hasReachedMax}) {
    return MediaListSuccessState(
        photos: photos ?? this.photos,
        videos: videos ?? this.videos,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [photos, videos, hasReachedMax];
}
