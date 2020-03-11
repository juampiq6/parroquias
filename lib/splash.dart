
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    Timer.run(() async  { await managePermission(); });
    return Center();
  }

  managePermission() async {
    var loc = Location();
    var status = await loc.hasPermission();
    if (status != PermissionStatus.GRANTED) {
      await loc.requestPermission();
      Navigator.pushReplacementNamed(context, 'home');
    }
    else { Navigator.pushReplacementNamed(context, 'home'); }

  }
}