import 'package:flutter/material.dart';
import 'package:qodehub_newshub/pages/home_page.dart';
import 'package:qodehub_newshub/utils/theme.dart';

//This is the entry point of all flutter apps.
void main() => runApp(NewsHub());

class NewsHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Building a MaterialApp to use Material widgets.
    return MaterialApp(
      title: 'NewsHub',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: HomePage(),
    );
  }
}
