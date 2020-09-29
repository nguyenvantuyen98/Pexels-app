import 'package:app/resource/resources.dart';
import 'package:app/src/data/repository/media_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoriteEvent {}

class FavoriteFetchEvent extends FavoriteEvent {}

class DislikeEvent extends FavoriteEvent {
  final int mediaTypeCode;
  final int mediaID;
  DislikeEvent({this.mediaTypeCode, this.mediaID});
}

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteFailureState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  final List mediaList;

  const FavoriteSuccessState({
    this.mediaList,
  });

  @override
  List<Object> get props => [mediaList];
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState());

  MediaRepository mediaRepository = MediaRepository();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is DislikeEvent) {
      await mediaRepository.delete(event.mediaTypeCode, event.mediaID);
      print('deteted');
    }
    if (event is FavoriteFetchEvent) {
      try {
        var data = await mediaRepository.mediaData();
        List mediaList = [];
        for (int i = 0; i < data.length; i++) {
          if (data[i][0] == photoCode) {
            var media = await mediaRepository.getImage('${data[i][1]}');
            mediaList.add(media);
          } else {
            var media = await mediaRepository.getVideo('${data[i][1]}');
            mediaList.add(media);
          }
        }

        yield FavoriteSuccessState(mediaList: mediaList);
      } catch (_) {
        yield FavoriteFailureState();
      }
    }
  }
}
