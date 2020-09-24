import '../../../models/video.dart';
import '../bloc/media_list_bloc.dart';
import 'package:flutter/material.dart';

class VideoWidget extends StatelessWidget {
  final Video video;
  VideoWidget({this.video});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
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
      ],
    );
  }
}
