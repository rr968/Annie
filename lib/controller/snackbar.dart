import 'package:flutter/material.dart';

snackbar(context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, textAlign: TextAlign.right),
      duration: const Duration(seconds: 2),
    ),
  );
}
