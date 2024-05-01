import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Everonewathed<T> extends StatelessWidget {
  final Future<T> future;
  const Everonewathed({
    Key? key,
    required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var movie = (snapshot.data as dynamic).results;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (var index = 0; index < movie.length; index++)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              movie[index].releaseDate.month.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              movie[index].releaseDate.day.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${movie[index].posterPath}',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    height: 50,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          'https://image.tmdb.org/t/p/w500${movie[index].posterPath}',
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Column(
                                    children: [
                                      Icon(
                                        Icons.notifications,
                                        size: 15,
                                      ),
                                      Text(
                                        'Remind me',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Column(
                                    children: [
                                      Icon(
                                        Icons.info_outline_rounded,
                                        size: 15,
                                      ),
                                      Text(
                                        'Info',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Coming on ${movie[index].releaseDate.month}/ ${movie[index].releaseDate.day}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie[index].overview,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 139, 255, 145),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
