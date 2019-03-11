import 'package:flutter/material.dart';

class TitleText{
  static titleTextStyle(){
    return TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }

  static mainTitleStyle(){
    return TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    );
  }

  static flatButtonTextStyle(){
    return TextStyle(
      color: Colors.black54,
    );
  }
}

class InputDeco{
  static textInputDeco(String title){
    return InputDecoration(
      labelText: title,
      border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
    );
  }
}