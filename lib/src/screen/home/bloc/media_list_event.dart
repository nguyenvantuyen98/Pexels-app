import 'package:equatable/equatable.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';

abstract class MediaListEvent extends Equatable {
  MediaListEvent();
}

class MediaTypeChanged extends MediaListEvent {
  final int mediaType;
  MediaTypeChanged({this.mediaType});

  @override
  List<Object> get props => [mediaType];
}

class ChoosePhoto extends MediaListEvent {
  final Photo photo;
  ChoosePhoto({this.photo});

  @override
  List<Object> get props => [photo];
}

class ChooseVideo extends MediaListEvent {
  final Video video;
  ChooseVideo({this.video});

  @override
  List<Object> get props => [video];
}

class FetchData extends MediaListEvent {
  FetchData();

  @override
  List<Object> get props => [];
}
