import 'package:app/router.dart';
import 'package:flutter/material.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pexels',
      initialRoute: 'home',
      onGenerateRoute: FluroRouter.router.generator,
    );
  }
}
