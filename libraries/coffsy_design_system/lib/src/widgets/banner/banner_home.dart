import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../coffsy_design_system.dart';

class BannerHome extends StatelessWidget {
  final Function(int index, CarouselPageChangedReason reason) onPageChanged;
  final List<ScreenData> data;
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
    this.isFromMovie = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = data.length > 10 ? 10 : data.length;

    return Column(
      children: <Widget>[
        // Banner
        SizedBox(
          height: MediaQuery.sizeOf(context).width / 2,
          child: CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              viewportFraction: 1,
              aspectRatio: 2,
              onPageChanged: onPageChanged,
            ),
            items: List.generate(
              result,
              (index) => ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed(
                      routeNameDetail,
                      arguments: ScreenArguments(
                        screenData: data[index],
                        isFromMovie: true,
                        isFromBanner: true,
                      ),
                      forRoot: true,
                    );
                  },
                  child: GridTile(
                    footer: Container(
                      color: ColorPalettes.whiteSemiTransparent,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        isFromMovie ? data[index].title : data[index].tvName ?? 'No Tv Name',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ColorPalettes.darkBG,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: data[index].backdropPath.imageOriginal,
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => const ErrorImage(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
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
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 2,
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
                Modular.to.pushNamed(
                  routeNameAll,
                  forRoot: true,
                );
              },
              child: const Text(
                'See all',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
