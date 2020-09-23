import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoadingEvent extends Equatable {
  LoadingEvent();
  @override
  List<Object> get props => [];
}

class LoadingMoreDataEvent extends LoadingEvent {
  LoadingMoreDataEvent();
}

class LoadingSuccessEvent extends LoadingEvent {
  LoadingSuccessEvent();
}

class LoadingFailEvent extends LoadingEvent {
  LoadingFailEvent();
}

abstract class LoadingState extends Equatable {
  LoadingState();
  @override
  List<Object> get props => [];
}

class LoadingMoreDataState extends LoadingState {
  LoadingMoreDataState();
}

class LoadingFailState extends LoadingState {
  LoadingFailState();
}

class LoadingDone extends LoadingState {
  LoadingDone();
}

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingDone());

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event) async* {
    if (event is LoadingMoreDataEvent) {
      yield LoadingMoreDataState();
    }
    if (event is LoadingFailEvent) {
      yield LoadingFailState();
    }
    if (event is LoadingSuccessEvent) {
      yield LoadingDone();
    }
  }
}
