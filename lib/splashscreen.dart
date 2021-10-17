import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sport_classification/home.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: const Home(),
      title: const Text(
        'Sport Classification',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
      ),
      image: Image.asset(
        'assets/sport1.jpeg',
      ),
      backgroundColor: Colors.grey,
      photoSize: 190,
      loaderColor: Colors.blueGrey,
    );
  }
}
