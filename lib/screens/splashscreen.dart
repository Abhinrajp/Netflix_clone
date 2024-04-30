import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:netflixclone/screens/bottomnavbar.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Bottomnavcontrollerscreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset('lib/assets/netflix.json'),
    );
  }
}
