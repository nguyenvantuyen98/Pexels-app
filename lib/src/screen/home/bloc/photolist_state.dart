import 'package:equatable/equatable.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';


abstract class PhotoListState extends Equatable {
  final String status;
  PhotoListState({this.status});

  @override
  List<Object> get props => [];
}

class InitialList extends PhotoListState {
  final String status;
  InitialList({this.status}) : super(status: status);
}

class ShowList extends PhotoListState {
  final List<Photo> photos;
  final List<Video> videos;
  ShowList({this.photos, this.videos, String status}) : super(status: status);
}

class Fetching extends PhotoListState {
  Fetching(String status) : super(status: status);
}

class FetchingFail extends PhotoListState {
  FetchingFail(String status) : super(status: status);
}
