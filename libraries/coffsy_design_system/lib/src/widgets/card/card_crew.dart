import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CardCrew extends StatelessWidget {
  final String image, name;

  const CardCrew({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: width / 4.4,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: GridTile(
            footer: Container(
              color: ColorPalettes.whiteSemiTransparent,
              padding: const EdgeInsets.all(5),
              child: Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ColorPalettes.darkBG,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: image.imageOriginal,
              height: width / 3,
              width: width / 4.4,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const ErrorImage(),
            ),
          ),
        ),
      ),
    );
  }
}
