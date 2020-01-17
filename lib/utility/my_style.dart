import 'package:flutter/material.dart';

class MyStyle {
  Color textColor = Color.fromARGB(0xff, 0x32, 0x19, 0x11);
  Color mainColor = Color.fromARGB(0xff, 0x8b, 0x6b, 0x61);
  Color barColor = Color.fromARGB(0xff, 0x5d, 0x40, 0x37);

  TextStyle h1TextStyle = TextStyle(
    fontFamily: 'Caveat',
    color: Color.fromARGB(0xff, 0x32, 0x19, 0x11),
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
  );

  TextStyle h1TextStyleWhite = TextStyle(
    fontFamily: 'Caveat',
    color: Colors.white,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
  );

  TextStyle h2TextStyle = TextStyle(
    fontFamily: 'Caveat',
    color: Color.fromARGB(0xff, 0x32, 0x19, 0x11),
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  TextStyle h2Title = TextStyle(
    color: Color.fromARGB(0xff, 0x32, 0x19, 0x11),
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  MyStyle();
}

class MyConstant {
  // String urlHost = 'http://desktop-pkdogbs:3001/';
  String urlHost = 'http://192.168.1.109:3001/';

  String urlUploadPic = 'http://192.168.1.109:90/dashboard/saveFile.php';
  String urlPic = 'http://192.168.1.109:90/dashboard/upload/';
  String urlInsertProduct = 'http://192.168.1.109:3001/api/users/upload';
  String urlGetAllProduct = 'http://192.168.1.109:3001/api/users/getpic';

  MyConstant();
}
