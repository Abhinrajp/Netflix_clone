import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/models/tvseiesmodel.dart';

class Customeslider extends StatelessWidget {
  final Tvseriesmodel data;
  const Customeslider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (context, index, realIndex) {
            var url = data.results[index].backdropPath.toString();

            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w500$url')),
                const SizedBox(
                  height: 20,
                ),
                Text(data.results[index].name)
              ],
            );
          },
          options: CarouselOptions(
              height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
              aspectRatio: 16 / 9,
              autoPlay: true,
              reverse: false,
              autoPlayInterval: const Duration(seconds: 1),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              initialPage: 0)),
    );
  }
}
