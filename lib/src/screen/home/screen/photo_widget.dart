import '../bloc/media_list_bloc.dart';
import '../../../models/image.dart';
import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;
  PhotoWidget({this.photo});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pushNamed(
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
                child: Image.network(photo.src.large, fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: 3.5, right: 3.5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              height: 100,
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}
