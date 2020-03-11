import 'package:flutter/material.dart';
import 'package:parroquias/splash.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: SplashScreen(),
      routes: {
        'home' : (_) => HomeScreen(),

      },
    );
  }
}