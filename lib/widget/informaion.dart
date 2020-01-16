import 'package:flutter/material.dart';
import 'package:ungbuilding/utility/my_style.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Information',
        style: MyStyle().h1TextStyle,
      ),
    );
  }
}
