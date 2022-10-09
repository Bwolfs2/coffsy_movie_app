import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class Poster extends StatelessWidget {
  static const posterRatio = 0.7;

  const Poster(this.posterUrl, this.height, {Key? key}) : super(key: key);

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    final width = posterRatio * height;
    return Material(
      borderRadius: BorderRadius.circular(Sizes.dp4(context)),
      elevation: 2,
      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: posterUrl,
        placeholder: (context, url) => const LoadingIndicator(),
        errorWidget: (context, url, error) => const ErrorImage(),
      ),
    );
  }
}
