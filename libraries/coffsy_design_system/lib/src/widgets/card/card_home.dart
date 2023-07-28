import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CardHome extends StatelessWidget {
  final String image, title;
  final VoidCallback onTap;
  final double rating;

  const CardHome({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.appBarTheme.backgroundColor == null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: AspectRatio(
          aspectRatio: 10 / 16,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Image
              CachedNetworkImage(
                imageUrl: image.imageOriginal,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const ErrorImage(),
              ),

              // Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.1, 0.98],
                    colors: [
                      ColorPalettes.transparent,
                      if (!isDarkTheme) ColorPalettes.white else ColorPalettes.darkBG,
                    ],
                  ),
                ),
              ),

              // Text and Rating
              Positioned(
                left: 6,
                bottom: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: !isDarkTheme ? ColorPalettes.darkBG : ColorPalettes.white,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),

                    // Rating
                    RatingBar(rating),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
