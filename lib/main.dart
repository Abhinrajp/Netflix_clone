import 'package:flutter/material.dart';
import 'package:netflixclone/colors.dart';
import 'package:netflixclone/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colours.scafoldbackground,
          useMaterial3: true),
      home: const Splashscreen(),
    );
  }
}
