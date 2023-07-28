import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CardMoviesHeader extends StatelessWidget {
  final bool isFromBanner;
  final int idMovie;
  final List<Widget> genre;
  final String title;
  final String imageBanner;
  final String imagePoster;
  final double rating;

  const CardMoviesHeader({
    Key? key,
    required this.isFromBanner,
    required this.idMovie,
    required this.genre,
    required this.title,
    required this.imageBanner,
    required this.imagePoster,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        RatingInformation(
          rating: rating,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: genre,
            ),
          ),
        ),
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: width / 3),
          child: ArcBannerImage(imageBanner),
        ),
        Positioned(
          bottom: 0,
          left: 16,
          right: 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Hero(
                tag: isFromBanner ? idMovie : imagePoster,
                child: MoviesPoster(
                  imagePoster,
                  width / 2,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}
