import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    color: Colors.white,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
  ),
);
