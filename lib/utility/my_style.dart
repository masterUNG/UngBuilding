import 'package:flutter/material.dart';

class MyStyle {
  Color textColor = Color.fromARGB(0xff, 0x6c, 0x6f, 0x00);
  Color mainColor = Color.fromARGB(0xff, 0x9e, 0x9d, 0x24);

  TextStyle h1TextStyle = TextStyle(
    fontFamily: 'Caveat',
    color: Color.fromARGB(0xff, 0x6c, 0x6f, 0x00),
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
  );

  TextStyle h2TextStyle = TextStyle(
    fontFamily: 'Caveat',
    color: Color.fromARGB(0xff, 0x6c, 0x6f, 0x00),
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  MyStyle();
}

class MyConstant {

  String urlHost = 'http://desktop-pkdogbs:3001/';

  MyConstant();
  
}
