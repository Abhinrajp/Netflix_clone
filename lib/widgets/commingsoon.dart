import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommingsoonWidget extends StatelessWidget {
  final String imageurl;
  final String overview;
  final String logo;
  final String month;
  final String day;
  const CommingsoonWidget(
      {super.key,
      required this.imageurl,
      required this.overview,
      required this.logo,
      required this.month,
      required this.day});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  month,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  day,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3),
                )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CachedNetworkImage(imageUrl: imageurl),
                  Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.2,
                        height: size.height * 0.2,
                        child: CachedNetworkImage(
                          imageUrl: logo,
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
                          )
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
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coming on $month $day',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        overview,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 139, 255, 145)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
