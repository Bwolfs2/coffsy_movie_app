import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CardHome extends StatelessWidget {
  final String image, title;
  final VoidCallback onTap;
  final double rating;

  const CardHome({Key? key, required this.image, required this.title, required this.onTap, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkTheme = theme.appBarTheme.color == null;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: Sizes.width(context) / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.dp10(context),
        ),
      ),
      child: Stack(
        children: <Widget>[
          // Image
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(
                Sizes.dp10(context),
              )),
              child: CachedNetworkImage(
                imageUrl: image.imageOriginal,
                height: Sizes.width(context) / 1.8,
                width: Sizes.width(context) / 2.5,
                fit: BoxFit.cover,
                placeholder: (context, url) => LoadingIndicator(),
                errorWidget: (context, url, error) => ErrorImage(),
              ),
            ),
          ),

          // Background
          Container(
            height: Sizes.width(context) / 1.8,
            width: Sizes.width(context) / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                Sizes.dp10(context),
              )),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.98],
                colors: [
                  ColorPalettes.transparent,
                  !isDarkTheme ? ColorPalettes.white : ColorPalettes.darkBG,
                ],
              ),
            ),
          ),

          // Text and Rating
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                  Sizes.dp10(context),
                )),
              ),
              padding: EdgeInsets.only(
                left: Sizes.dp6(context),
                bottom: Sizes.dp5(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: Sizes.dp14(context),
                        fontWeight: FontWeight.bold,
                        color: !isDarkTheme ? ColorPalettes.darkBG : ColorPalettes.white),
                  ),
                  SizedBox(
                    height: Sizes.dp4(context),
                  ),

                  // Rating
                  buildRatingBar(theme, context, rating),
                  SizedBox(
                    height: Sizes.dp10(context),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                Sizes.dp10(context),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  Sizes.dp10(context),
                ),
                onTap: onTap,
              ),
            ),
          )
        ],
      ),
    );
  }
}
