import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/apiservices/api.dart';
import 'package:netflixclone/models/moviedetail.dart';
import 'package:netflixclone/models/recomentationmovie.dart';
import 'package:apivideo_player/apivideo_player.dart';

class Detailscreen extends StatefulWidget {
  final int movieid;
  const Detailscreen({Key? key, required this.movieid}) : super(key: key);

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  Apiservices apiservices = Apiservices();

  late Future<Getmoviedetailmodel> moviedetail;
  late Future<Getrecomentationmoviemodel> recomented;
  late ApiVideoPlayerController controller;
  bool showVideo = false;

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  fetchdata() {
    moviedetail = apiservices.getmoviedetails(widget.movieid);
    recomented = apiservices.getMovieRecommendation(widget.movieid);
    moviedetail.then((movie) {
      bool hasVideo = movie.video;

      if (hasVideo) {
        controller = ApiVideoPlayerController(
          videoOptions: VideoOptions(videoId: movie.video.toString()),
        );
        print("the video ul isssssssssssssssssssss ${movie.video.toString()}");

        controller.initialize();

        Timer(const Duration(seconds: 1), () {
          setState(() {
            showVideo = true;
          });

          controller.play();
        });

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: moviedetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null) {
            return const Text('No Movies');
          } else {
            final movie = snapshot.data as Getmoviedetailmodel;

            String genresText =
                movie.genres.map((genre) => genre.name).join(', ');

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            ),
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (showVideo)
                        Positioned.fill(
                          child: ApiVideoPlayer(
                            controller: controller,
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SafeArea(
                          child: Align(
                            child: Row(
                              children: [
                                Text(
                                  movie.releaseDate.year.toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    genresText,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          movie.overview,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                    future: recomented,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movierec =
                            snapshot.data as Getrecomentationmoviemodel;
                        return movierec.results.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const Text('More like this'),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 300,
                                    child: GridView.builder(
                                      itemCount: movierec.results.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 5,
                                        childAspectRatio: 1.5 / 2,
                                      ),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Detailscreen(
                                                  movieid: movierec
                                                      .results[index].id,
                                                ),
                                              ),
                                            );
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${movierec.results[index].posterPath}',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
