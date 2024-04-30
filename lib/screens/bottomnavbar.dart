import 'package:flutter/material.dart';
import 'package:netflixclone/screens/homescreen.dart';
import 'package:netflixclone/screens/newandhotscreen.dart';
import 'package:netflixclone/screens/searchscreen.dart';

class Bottomnavcontrollerscreen extends StatelessWidget {
  const Bottomnavcontrollerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 62,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.search),
                text: 'Search',
              ),
              Tab(
                icon: Icon(
                  Icons.photo_library_outlined,
                ),
                text: 'New & Hot',
              ),
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: const TabBarView(children: [
          Homescreen(),
          Searchscreen(),
          Newandhotscreen(),
        ]),
      ),
    );
  }
}
