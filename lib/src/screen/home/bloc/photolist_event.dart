import 'package:equatable/equatable.dart';
import 'package:app/src/data/repository/media_repository.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';


/******************************************************************************************
 * 
 * PHOTO LIST EVENT
 * 
 ******************************************************************************************/

abstract class PhotoListEvent extends Equatable {
  final MediaType status;
  final int page;
  final String keyWord;
  PhotoListEvent({this.status, this.page, this.keyWord = ''});
}

class StatusChanged extends PhotoListEvent {
  StatusChanged({MediaType status, int page, String keyWord})
      : super(status: status, page: page, keyWord: keyWord);

  @override
  List<Object> get props => [status, page, keyWord];
}

class ChooseImage extends PhotoListEvent {
  final Photo image;
  ChooseImage({this.image});

  @override
  List<Object> get props => [image];
}

class ChooseVideo extends PhotoListEvent {
  final Video video;
  ChooseVideo({this.video});

  @override
  List<Object> get props => [video];
}

class FetchData extends PhotoListEvent {
  FetchData({MediaType mediaType, int page, String keyWord})
      : super(status: mediaType, page: page, keyWord: keyWord);

  @override
  List<Object> get props => [status, page, keyWord];
}

/******************************************************************************************
 * 
 * SEARCH EVENT
 * 
 ******************************************************************************************/


