import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class ArcBannerImage extends StatelessWidget {
  const ArcBannerImage(this.imageUrl, {Key? key}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return ClipPath(
      clipper: ArcClipper(),
      child: SizedBox(
        width: width,
        height: width / 1.8,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => const ErrorImage(),
        ),
      ),
    );
  }
}
