import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Splachscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          body: EasySplashScreen(
        backgroundColor: Colors.pinkAccent,
        showLoader: true,
        loadingText: Text("Loding..."),
        logoSize: 170,
        logo: Image.asset("images/s3.jpg"),
        navigator: MyHomePage(),
        durationInSeconds: 5,
      )),
    );
  }
}
