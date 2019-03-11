import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:alevelapp/src/screens/login_screen/login_screen.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: LoginScreen(),
        title: Text(
          'Welcome to A-LEVEL App!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image(image: AssetImage('assets/images/icon.png')),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.green);
  }
}
