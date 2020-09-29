import 'package:app/resource/resources.dart';
import 'package:app/src/data/repository/media_repository.dart';
import 'package:app/src/model/image.dart';
import 'package:app/src/model/video.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MediaDetailEvent {
  MediaDetailEvent();
}

class InitialMediaDetailEvent extends MediaDetailEvent {
  final String mediaType;
  final String mediaKey;
  InitialMediaDetailEvent({this.mediaType, this.mediaKey});
}

class LikedEvent extends MediaDetailEvent {
  final int mediaTypeCode;
  final int mediaID;
  LikedEvent({this.mediaTypeCode, this.mediaID});
}

abstract class MediaDetailState extends Equatable {
  MediaDetailState();
  @override
  List<Object> get props => [];
}

class InitialMediaDetailState extends MediaDetailState {
  InitialMediaDetailState();
}

class LoadingMediaState extends MediaDetailState {
  LoadingMediaState();
}

class LoadingFailMediaState extends MediaDetailState {
  LoadingFailMediaState();
}

class ShowMediaState extends MediaDetailState {
  final int mediaType;
  final Photo photo;
  final Video video;
  final List<Photo> relatedPhoto;
  final List<Video> relatedVideo;
  ShowMediaState(
      {this.mediaType,
      this.photo,
      this.video,
      this.relatedPhoto,
      this.relatedVideo});
}

class MediaDetailBloc extends Bloc<MediaDetailEvent, MediaDetailState> {
  MediaDetailBloc() : super(InitialMediaDetailState());
  MediaRepository mediaRepository = MediaRepository();

  @override
  Stream<MediaDetailState> mapEventToState(MediaDetailEvent event) async* {
    if (event is LikedEvent) {
      if (await mediaRepository.isContain(event.mediaTypeCode, event.mediaID)) {
        await mediaRepository.delete(event.mediaTypeCode, event.mediaID);
      } else {
        await mediaRepository.insert(event.mediaTypeCode, event.mediaID);
      }
    }
    if (event is InitialMediaDetailEvent) {
      yield LoadingMediaState();
      if (event.mediaType == '$photoCode') {
        Photo photo = await mediaRepository.getImage(event.mediaKey);
        List<Photo> relatedPhoto = await mediaRepository.relatedImage(photo);
        yield ShowMediaState(
            mediaType: photoCode, photo: photo, relatedPhoto: relatedPhoto);
      } else {
        Video video = await mediaRepository.getVideo(event.mediaKey);
        List<Video> relatedVideo = await mediaRepository.relatedVideo(video);
        yield ShowMediaState(
            mediaType: videoCode, video: video, relatedVideo: relatedVideo);
      }
    }
  }
}
