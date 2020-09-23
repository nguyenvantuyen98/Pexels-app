import 'package:app/src/data/repository/media_repository.dart';
import 'package:app/src/models/image.dart';
import 'package:app/src/models/video.dart';
import 'package:app/src/screen/home/bloc/media_list_bloc.dart';
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
