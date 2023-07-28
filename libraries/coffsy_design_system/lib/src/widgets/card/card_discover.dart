import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';
import '../shimmer/shimmer_discover.dart';

class CardDiscover extends StatelessWidget {
  final String image, title;
  final double rating;
  final List<int> genre;
  final VoidCallback onTap;

  const CardDiscover({
    Key? key,
    required this.image,
    required this.title,
    required this.rating,
    required this.genre,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            width: width / 2,
            child: AspectRatio(
              aspectRatio: 10 / 16,
              child: GestureDetector(
                onTap: onTap,
                child: CachedNetworkImage(
                  imageUrl: image.imageOriginal,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ShimmerDiscover(),
                  errorWidget: (context, url, error) => const ErrorImage(),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: genre.take(3).map((id) => GenreChip(genreId: id)).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          rating.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: width / 16,
          ),
        ),
        RatingBar(rating),
      ],
    );
  }
}
