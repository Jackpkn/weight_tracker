import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        content: Text(content, style: const TextStyle(color: Colors.white)),
      ),
    );
}
