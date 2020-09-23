import 'package:app/src/screen/home/bloc/loading_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/image.dart';
import '../../../models/video.dart';
import '../bloc/media_list_bloc.dart';
import '../bloc/media_list_event.dart';
import '../bloc/media_list_state.dart';

class ListMedia extends StatefulWidget {
  final int mediaType;
  ListMedia({this.mediaType, Key key}) : super(key: key);

  @override
  _ListMediaState createState() => _ListMediaState();
}

class _ListMediaState extends State<ListMedia> {
  final _scrollController = ScrollController();
  MediaListBloc _mediaListBloc;
  LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _mediaListBloc = BlocProvider.of<MediaListBloc>(context);
    _loadingBloc = BlocProvider.of<LoadingBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll < 200) {
      _mediaListBloc.add(FetchDataEvent());
      _loadingBloc.add(LoadingMoreDataEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaListBloc, MediaListState>(
      builder: (BuildContext context, state) {
        if (state is InitialListState) {
          _mediaListBloc.add(FetchDataEvent());
          return Center(child: CircularProgressIndicator());
        }
        if (state is FetchingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ShowListState) {
          return CustomScrollView(controller: _scrollController, slivers: [
            SliverGrid.extent(
              maxCrossAxisExtent: 650,
              children: widget.mediaType == photoCode
                  ? _builPhotoList(state.photos)
                  : _buildVideoList(state.videos),
            ),
          ]);
        }
        return Center(
          child: Text('Something wrong'),
        );
      },
    );
  }

  List<Widget> _builPhotoList(List<Photo> photos) {
    List<GestureDetector> imagesList = [];
    for (Photo photo in photos) {
      imagesList.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'mediaDetail/$photoCode/${photo.id}');
          },
          child: Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Image.network(photo.src.large, fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }
    return imagesList;
  }

  List<Widget> _buildVideoList(List<Video> videos) {
    List<GestureDetector> videosList = [];
    for (Video video in videos) {
      videosList.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'mediaDetail/$videoCode/${video.id}');
          },
          child: Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Image.network(video.videoPictures[0].picture,
                  fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }
    return videosList;
  }
}

class PageViewMedia extends StatefulWidget {
  final PageController _pageController;

  const PageViewMedia(this._pageController);
  @override
  _PageViewMediaState createState() => _PageViewMediaState();
}

class _PageViewMediaState extends State<PageViewMedia> {
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: _bucket,
      child: PageView(
        controller: widget._pageController,
        onPageChanged: (int page) {
          BlocProvider.of<MediaListBloc>(context)
              .add(MediaTypeChangedEvent(mediaType: page));
        },
        children: [
          ListMedia(mediaType: photoCode, key: PageStorageKey('photo')),
          ListMedia(mediaType: videoCode, key: PageStorageKey('video')),
        ],
      ),
    );
  }
}
