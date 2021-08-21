import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CardDiscover extends StatelessWidget {
  final String image, title;
  final double rating;
  final List<int> genre;
  final VoidCallback onTap;

  const CardDiscover({Key? key, required this.image, required this.title, required this.rating, required this.genre, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dp20(context)),
          child: GestureDetector(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: image.imageOriginal,
              width: Sizes.width(context) / 2,
              placeholder: (context, url) => ShimmerDiscover(),
              errorWidget: (context, url, error) => ErrorImage(),
            ),
          ),
        ),
        SizedBox(
          height: Sizes.height(context) * .02,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: Sizes.width(context) / 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: Sizes.height(context) * .01,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: genre.take(3).map((id) => GenreChip(id: id)).toList(),
          ),
        ),
        SizedBox(
          height: Sizes.height(context) * .01,
        ),
        Text(
          rating.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: Sizes.width(context) / 16,
          ),
        ),
        SizedBox(
          height: Sizes.height(context) * .005,
        ),
        buildRatingBar(theme, context, rating),
      ],
    );
  }
}
