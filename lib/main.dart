import 'package:flutter/material.dart';
import 'package:app/src/screen/home/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pexels',
      home: HomeScreen(),
    );
  }
}
