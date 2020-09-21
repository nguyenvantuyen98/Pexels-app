import 'package:app/src/screen/home/screen/home_screen.dart';
import 'package:app/src/screen/photo_details/photo_details_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeScreen());
  static Handler _photoDetailHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          PhotoDetail());
  static void setupRouter() {
    router.define('home', handler: _homeHandler);
    router.define('photoDetail', handler: _photoDetailHandler);
  }
}
