import 'package:flutter/material.dart';
import 'package:ungbuilding/utility/my_style.dart';

Widget showTitle(String title) {
  return ListTile(
    title: Text(
      title,
      style: MyStyle().h1TextStyle,
    ),
    leading: Icon(
      Icons.add_alert,
      size: 36.0,
      color: MyStyle().textColor,
    ),
  );
}

Widget okButton(BuildContext buildContext) {
  return FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(buildContext).pop();
    },
  );
}

Future<void> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: showTitle(title),
          content: Text(message),
          actions: <Widget>[okButton(buildContext)],
        );
      });
}
