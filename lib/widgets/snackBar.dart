// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Color.fromARGB(255, 105, 7, 0),
      duration: Duration(seconds: 5),
      content: Text(text),
      action: SnackBarAction(label: "close", onPressed: () {}),
    ),
  );
}
//mahmoud@yahoo.com
