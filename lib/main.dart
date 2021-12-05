//loading screen
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:untitled/Location.dart';
import 'package:untitled/Result.dart';
import 'package:untitled/input.dart';

import 'Route.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner:false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: RoutePage(),
      title: new Text(
        'Welcome',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.asset(
          'assets/businessLogo copy.png'),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,

      photoSize: 80,

    );
  }
}
