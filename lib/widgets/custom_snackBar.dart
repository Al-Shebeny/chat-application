import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String tittle) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(tittle),
    ),
  );
}
