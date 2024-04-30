import 'package:flutter/material.dart';
import 'package:netflixclone/apiservices/api.dart';
import 'package:netflixclone/models/nowplayingmodel.dart';
import 'package:netflixclone/models/tvseiesmodel.dart';
import 'package:netflixclone/models/upcomingmovie.dart';
import 'package:netflixclone/screens/searchscreen.dart';
import 'package:netflixclone/widgets/carousel.dart';
import 'package:netflixclone/widgets/moviecard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<Upcomingmoviemodel> upcomingmoviesfromapinew;
  late Future<Nowplayingmoviemodel> nowplayingmoviefromapinew;
  late Future<Tvseriesmodel> topratedseiresfromapinew;
  @override
  void initState() {
    super.initState();

    upcomingmoviesfromapinew = Apiservices().getupcomingmovie();
    nowplayingmoviefromapinew = Apiservices().nowplayingmovie();
    topratedseiresfromapinew = Apiservices().gettoprated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.amber,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Searchscreen(),
                    ));
              },
              icon: const Icon(
                Icons.search,
                size: 28,
              )),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'lib/assets/Logonetflix.png',
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          height: 50,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: topratedseiresfromapinew,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Customeslider(data: snapshot.data!);
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(
                  height: 250,
                  child: Moviecard(
                      future: nowplayingmoviefromapinew,
                      headline: 'Now Playing ')),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 250,
                  child: Moviecard(
                      future: upcomingmoviesfromapinew,
                      headline: 'Upcoming Movies')),
            ],
          ),
        ),
      ),
    );
  }
}
