import 'package:flutter/material.dart';

void showSuccessSnackBar({BuildContext context, String message}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(milliseconds: 500),
    backgroundColor: Colors.green[300],
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
  ));
}

void showFailureSnakcBar({BuildContext context, String message}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(milliseconds: 500),
    backgroundColor: Colors.red[300],
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
  ));
}
