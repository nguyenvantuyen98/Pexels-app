import 'package:app/src/model/image.dart';
import 'package:app/src/screens/home/screen/home_screen.dart';
import '../bloc/media_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_list_event.dart';
import '../bloc/media_list_bloc.dart';
import 'package:flutter/material.dart';
import 'media_widget.dart';

typedef void BottomNavigationIndex(int index);

class PageViewMedia extends StatefulWidget {
  final PageController pageController;
  final BottomNavigationIndex callback;
  PageViewMedia({this.pageController, this.callback});

  @override
  _PageViewMediaState createState() => _PageViewMediaState();
}

class _PageViewMediaState extends State<PageViewMedia> {
  double photoPagePosition = 0.0;
  double videoPagePosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      onPageChanged: (int page) {
        BlocProvider.of<MediaListBloc>(context)
            .add(MediaListTypeChangeEvent(mediaTypeCode: page));
        widget.callback(page);
      },
      children: [
        MediaPage(
          mediaTypeCode: photoCode,
          callback: (position) {
            photoPagePosition = position;
            print('photo position is $position');
          },
        ),
        MediaPage(
          mediaTypeCode: videoCode,
          callback: (position) {
            videoPagePosition = position;
            print('video position is $position');
          },
        ),
      ],
    );
  }
}

typedef void PositionCallback(double position);

class MediaPage extends StatefulWidget {
  final int mediaTypeCode;
  final PositionCallback callback;
  MediaPage({this.mediaTypeCode, this.callback});
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  ScrollController _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  MediaListBloc _mediaListBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _mediaListBloc = BlocProvider.of<MediaListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (context, state) {
        if (state is MediaListInitialState) {
          _mediaListBloc.add(MediaListFetchedEvent());
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MediaListFailureState) {
          return Center(
            child: Text('failed to fetch MediaLists'),
          );
        }
        if (state is MediaListSuccessState) {
          if (widget.mediaTypeCode == photoCode) {
            if (state.photos.isEmpty) {
              return Center(
                child: Text('no MediaLists'),
              );
            }
          } else {
            if (state.videos.isEmpty) {
              return Center(
                child: Text('no MediaLists'),
              );
            }
          }

          return widget.mediaTypeCode == photoCode
              ? BuildMediaListWidget(
                  mediaList: state.photos,
                  hasReachedMax: state.hasReachedMax,
                  scrollController: _scrollController,
                )
              : BuildMediaListWidget(
                  mediaList: state.videos,
                  hasReachedMax: state.hasReachedMax,
                  scrollController: _scrollController,
                );
        } else
          return Center(
            child: Text('Something wrong'),
          );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    widget.callback(currentScroll);
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _mediaListBloc.add(MediaListFetchedEvent());
    }
  }
}

class BuildMediaListWidget extends StatelessWidget {
  final List mediaList;
  final bool hasReachedMax;
  final ScrollController scrollController;
  final double position;
  BuildMediaListWidget(
      {this.mediaList,
      this.hasReachedMax,
      this.scrollController,
      this.position});
  @override
  Widget build(BuildContext context) {
    if (position != null && scrollController.hasClients)
      scrollController.jumpTo(position);
    if (mediaList[0] is Photo) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 650 + 1),
        itemBuilder: (BuildContext context, int index) {
          return index >= mediaList.length
              ? BottomLoader()
              : BuildMediaWidget(
                  photo: mediaList[index],
                  index: index,
                );
        },
        itemCount: hasReachedMax ? mediaList.length : mediaList.length + 1,
        controller: scrollController,
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 650 + 1),
        itemBuilder: (BuildContext context, int index) {
          return index >= mediaList.length
              ? BottomLoader()
              : BuildMediaWidget(
                  video: mediaList[index],
                  index: index,
                );
        },
        itemCount: hasReachedMax ? mediaList.length : mediaList.length + 1,
        controller: scrollController,
      );
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
