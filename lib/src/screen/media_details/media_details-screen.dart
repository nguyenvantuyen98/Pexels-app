import 'package:app/src/screen/home/bloc/media_list_bloc.dart';
import 'package:app/src/screen/media_details/bloc/media_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class MediaDetailScreen extends StatelessWidget {
  final String mediaType;
  final String mediaKey;

  MediaDetailScreen(this.mediaType, this.mediaKey);
  @override
  Widget build(BuildContext context) {
    print(mediaType);
    print(mediaKey);
    return BlocProvider(
      create: (BuildContext context) => MediaDetailBloc(),
      child: MediaDetail(mediaType, mediaKey),
    );
  }
}

class MediaDetail extends StatelessWidget {
  final String mediaType;
  final String mediaKey;
  MediaDetail(this.mediaType, this.mediaKey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<MediaDetailBloc, MediaDetailState>(
          builder: (BuildContext context, state) {
        if (state is InitialMediaDetailState) {
          BlocProvider.of<MediaDetailBloc>(context).add(
            InitialMediaDetailEvent(mediaType: mediaType, mediaKey: mediaKey),
          );
        }
        if (state is LoadingMediaState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ShowMediaState) {
          if (state.mediaType == photoCode) {
            return Center(child: Image.network(state.photo.src.large));
          } else {
            return VideoPlayerScreen(video: state.video.videoFiles[0].link);
          }
        } else {
          return Text('Something wrong');
        }
      }),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String video;
  VideoPlayerScreen({Key key, this.video}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.video,
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        },
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
