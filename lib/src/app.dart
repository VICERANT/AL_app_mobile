import 'package:alevelapp/src/screens/email_verification_screen/email_verification.dart';
import 'package:alevelapp/src/screens/home_screen/home_screen.dart';
import 'package:alevelapp/src/screens/login_screen/login_screen.dart';
import 'package:alevelapp/src/screens/register_screen/register_stepper.dart';
import 'package:alevelapp/src/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'AL App',
      home: SplashScreenPage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginScreen(),
        '/home': (BuildContext context) => HomeScreen(),
        '/verfication': (BuildContext context) => EmailVerification(),
        '/register': (BuildContext context) => RegisterStepper(),
      },
    );
  }
}