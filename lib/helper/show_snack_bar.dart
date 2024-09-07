import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, TextStyle color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      content: Text(message, style: color),
    ),
  );
}
