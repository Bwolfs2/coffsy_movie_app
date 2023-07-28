import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class MoviesPoster extends StatelessWidget {
  static const posterRatio = 0.7;

  const MoviesPoster(this.posterUrl, this.height, {Key? key}) : super(key: key);

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    final width = posterRatio * height;

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      elevation: 2,
      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: posterUrl,
        errorWidget: (context, url, error) => const ErrorImage(),
      ),
    );
  }
}
