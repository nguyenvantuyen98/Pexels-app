import 'package:equatable/equatable.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';

abstract class PhotoListState extends Equatable {
  final String mediaType;
  PhotoListState({this.mediaType});

  @override
  List<Object> get props => [];
}

class InitialList extends PhotoListState {
  final String mediaType;
  InitialList({this.mediaType}) : super(mediaType: mediaType);
}

class ShowList extends PhotoListState {
  final List<Photo> photos;
  final List<Video> videos;
  ShowList({this.photos, this.videos, String status})
      : super(mediaType: status);
}

class Fetching extends PhotoListState {
  Fetching(String status) : super(mediaType: status);
}

class FetchingFail extends PhotoListState {
  FetchingFail(String status) : super(mediaType: status);
}
