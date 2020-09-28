import 'package:equatable/equatable.dart';

abstract class MediaListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MediaListFetchedEvent extends MediaListEvent {}

class MediaListTypeChangeEvent extends MediaListEvent {
  final int mediaTypeCode;
  MediaListTypeChangeEvent({this.mediaTypeCode});
}

class SearchMediaEvent extends MediaListEvent {
  final String keyWord;
  SearchMediaEvent({this.keyWord = ''});
  @override
  List<Object> get props => [];
}

class LikeMediaEvent extends MediaListEvent {
  final int mediaTypeCode;
  final int mediaID;
  LikeMediaEvent({this.mediaTypeCode, this.mediaID});
  @override
  List<Object> get props => [mediaTypeCode, mediaID];
}
