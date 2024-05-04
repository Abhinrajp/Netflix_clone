import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/apiservices/api.dart';
import 'package:netflixclone/apiservices/debuncer.dart';
import 'package:netflixclone/models/recomentationmovie.dart';
import 'package:netflixclone/models/searchmodel.dart';
import 'package:netflixclone/screens/detailscreen.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  TextEditingController searchcontroller = TextEditingController();
  Apiservices apiservices = Apiservices();
  late Future<Getrecomentationmoviemodel> popularmovie;
  Getsearchmoviemodel? getsearchmoviemodel;
  void seaarch(String query) {
    apiservices.getsearchmovie(query).then((value) {
      setState(() {
        getsearchmoviemodel = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    popularmovie = apiservices.getpopularmovie();
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CupertinoSearchTextField(
                    controller: searchcontroller,
                    onChanged: (value) {
                      if (value.isEmpty) {
                      } else {
                        debouncer.call(() {
                          seaarch(searchcontroller.text);
                        });
                      }
                    },
                  ),
                ),
                searchcontroller.text.isEmpty
                    ? FutureBuilder(
                        future: popularmovie,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = (snapshot.data as dynamic).results;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  'Top Search',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        dismissKeyboard();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Detailscreen(
                                                movieid: data[index].id,
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        height: 200,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Image.network(
                                                'https://image.tmdb.org/t/p/w500${data[index].posterPath}'),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${data[index].title}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.visible,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      )
                    : getsearchmoviemodel == null
                        ? const Text('No filim ')
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: getsearchmoviemodel!.results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1.2 / 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  dismissKeyboard();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Detailscreen(
                                          movieid: getsearchmoviemodel!
                                              .results[index].id,
                                        ),
                                      ));
                                },
                                child: Column(
                                  children: [
                                    getsearchmoviemodel!
                                            .results[index].backdropPath.isEmpty
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 38),
                                            child: Image.asset(
                                                'lib/assets/netflixlogo.0.0.1466448626.webp'),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                'https://image.tmdb.org/t/p/w500${getsearchmoviemodel!.results[index].backdropPath}',
                                            height: 150,
                                          ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        getsearchmoviemodel!
                                            .results[index].originalTitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }
}
