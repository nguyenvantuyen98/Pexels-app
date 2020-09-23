import 'package:app/src/models/image.dart';
import 'package:app/src/screen/home/bloc/media_list_bloc.dart';
import 'package:rubber/rubber.dart';
import '../bloc/media_detail_bloc.dart';
import 'package:flutter/material.dart';

class PhotoShowScreen extends StatefulWidget {
  final ShowMediaState state;
  PhotoShowScreen({this.state});
  @override
  _PhotoShowScreenState createState() => _PhotoShowScreenState();
}

class _PhotoShowScreenState extends State<PhotoShowScreen>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.9),
        duration: Duration(milliseconds: 200),
        initialValue: 0.1);
    _controller.addStatusListener(_statusListener);
    _controller.animationState.addListener(_stateListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.animationState.removeListener(_stateListener);
    super.dispose();
  }

  void _stateListener() {}

  void _statusListener(AnimationStatus status) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RubberBottomSheet(
        lowerLayer: _getLowerLayer(),
        upperLayer: _getUpperLayer(),
        animationController: _controller,
      ),
    );
  }

  Widget _getLowerLayer() {
    return Center(child: Image.network(widget.state.photo.src.large));
  }

  Widget _getUpperLayer() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _builPhotoList(widget.state.relatedPhoto, context),
        ),
      ),
    );
  }

  List<Widget> _builPhotoList(List<Photo> photos, BuildContext context) {
    List<GestureDetector> imagesList = [];
    for (Photo photo in photos) {
      imagesList.add(
        GestureDetector(
          onTap: () {
            Navigator.popAndPushNamed(
                context, 'mediaDetail/$photoCode/${photo.id}');
          },
          child: Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Image.network(photo.src.small, fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }
    return imagesList;
  }
}
