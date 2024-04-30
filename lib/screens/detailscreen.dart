import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/apiservices/api.dart';
import 'package:netflixclone/models/moviedetail.dart';
import 'package:netflixclone/models/recomentationmovie.dart';

class Detailscreen extends StatefulWidget {
  final int movieid;
  const Detailscreen({super.key, required this.movieid});

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  Apiservices apiservices = Apiservices();

  late Future<Getmoviedetailmodel> moviedetail;
  late Future<Getrecomentationmoviemodel> recomented;

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  fetchdata() {
    moviedetail = apiservices.getmoviedetails(widget.movieid);
    recomented = apiservices.getMovieRecommendation(widget.movieid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("this is the moviee idddddddddddddddddddddddddd${widget.movieid}");
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
              return const Text('No data available');
            } else {
              final movie = snapshot.data;
              String genresText =
                  movie!.genres.map((genre) => genre.name).join(', ');

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
                                  ))),
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.arrow_back_ios))
                              ],
                            ),
                          ),
                        )
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
                                      style:
                                          const TextStyle(color: Colors.grey),
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
                            final movierec = snapshot.data;
                            return movierec!.results.isEmpty
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
                                                    ));
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
                        })
                  ],
                ),
              );
            }
          }),
    );
  }
}
