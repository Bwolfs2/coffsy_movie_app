import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BannerHome extends StatelessWidget {
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;
  final Result data;
  final int currentIndex;
  final String routeNameDetail, routeNameAll;
  final bool isFromMovie;

  const BannerHome({
    Key? key,
    required this.onPageChanged,
    required this.data,
    required this.currentIndex,
    required this.routeNameDetail,
    required this.routeNameAll,
    this.isFromMovie: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var result = data.results.length > 10 ? 10 : data.results.length;
    return Column(
      children: <Widget>[
        // Banner
        Container(
          height: Sizes.width(context) / 2,
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              viewportFraction: 1.0,
              aspectRatio: 2.0,
              onPageChanged: onPageChanged,
            ),
            items: <Widget>[
              for (var i = 0; i < result; i++)
                ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.dp10(context)),
                  child: GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed(
                        routeNameDetail,
                        arguments: ScreenArguments(data.results[i], true, true),
                      );
                    },
                    child: GridTile(
                      child: CachedNetworkImage(
                        imageUrl: data.results[i].backdropPath.imageOriginal,
                        width: Sizes.width(context),
                        fit: BoxFit.fill,
                        placeholder: (context, url) => LoadingIndicator(),
                        errorWidget: (context, url, error) => ErrorImage(),
                      ),
                      footer: Container(
                        color: ColorPalettes.whiteSemiTransparent,
                        padding: EdgeInsets.all(Sizes.dp5(context)),
                        child: Text(
                          isFromMovie ? data.results[i].title : data.results[i].tvName ?? 'No Tv Name',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ColorPalettes.darkBG,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.dp16(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    result,
                    (index) => Container(
                      width: Sizes.dp8(context),
                      height: Sizes.dp8(context),
                      margin: EdgeInsets.symmetric(
                        vertical: Sizes.dp10(context),
                        horizontal: 2.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index ? ColorPalettes.darkAccent : ColorPalettes.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Modular.to.pushNamed(routeNameAll, forRoot: true);
              },
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: Sizes.dp15(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
