import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class ArcBannerImage extends StatelessWidget {
  const ArcBannerImage(this.imageUrl, {Key? key}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ArcClipper(),
      child: SizedBox(
        width: Sizes.width(context),
        height: Sizes.width(context) / 1.8,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          placeholder: (context, url) => const LoadingIndicator(),
          errorWidget: (context, url, error) => const ErrorImage(),
        ),
      ),
    );
  }
}
