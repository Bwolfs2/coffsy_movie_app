import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class GenreChip extends StatelessWidget {
  final int id;
  const GenreChip({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalettes.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        Genres.genres[id] ?? 'No Gender',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

class Genres {
  static Map<int, String> genres = {
    10759: 'Action & Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    10762: 'Kids',
    9648: 'Mystery',
    10763: 'News',
    10764: 'Reality',
    10765: 'Sci-Fi & Fantasy',
    10766: 'Soap',
    10767: 'Talk',
    10768: 'War & Politics',
    37: 'Western',
    28: 'Action',
    12: 'Adventure',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
  };
}
