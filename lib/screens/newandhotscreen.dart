import 'package:flutter/material.dart';
import 'package:netflixclone/apiservices/api.dart';
import 'package:netflixclone/models/toprated.dart';
import 'package:netflixclone/models/upcomingmovie.dart';
import 'package:netflixclone/widgets/everonewatched.dart';

class Newandhotscreen extends StatefulWidget {
  const Newandhotscreen({super.key});

  @override
  State<Newandhotscreen> createState() => _NewandhotscreenState();
}

class _NewandhotscreenState extends State<Newandhotscreen> {
  late Future<Gettopratedmoviemodel> topratedmovie;
  late Future<Upcomingmoviemodel> upcomingmovie;
  @override
  void initState() {
    super.initState();
    topratedmovie = Apiservices().getnewandhottoprated();
    upcomingmovie = Apiservices().getupcomingmovie();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'New & Hot',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Icon(Icons.cast_rounded),
              const SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 27,
                  width: 27,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
            bottom: const TabBar(
                dividerColor: Colors.transparent,
                isScrollable: false,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                labelColor: Colors.black,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    text: '🍿Comming Soon',
                  ),
                  Tab(
                    text: '''🔥Everyone's watching''',
                  )
                ]),
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                children: [Everonewathed(future: topratedmovie)],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Everonewathed(future: upcomingmovie),
                ],
              ),
            ),
          ]),
        )));
  }
}
