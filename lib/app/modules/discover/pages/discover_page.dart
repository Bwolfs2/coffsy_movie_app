import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../errors/discover_failures.dart';
import 'discover_store.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final store = DiscoverStore(Modular.get());

  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: ColorPalettes.white,
        ),
      ),
      body: ScopedBuilder<DiscoverStore, Failure, Result>.transition(
        onError: (context, error) => error is DiscoverMovieNoInternetConnection
            ? NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () async => await store.load(),
              )
            : CustomErrorWidget(message: error?.errorMessage),
        onLoading: (context) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        onState: (context, state) => PageView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: state.results.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var movie = state.results[index];
            var position = index + 1;
            return Container(
              width: Sizes.width(context),
              height: Sizes.height(context),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: movie.backdropPath.imageOriginal,
                    width: Sizes.width(context),
                    height: Sizes.height(context),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => LoadingIndicator(),
                    errorWidget: (context, url, error) => ErrorImage(),
                  ),
                  Container(
                    color: ColorPalettes.grey.withOpacity(.6),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            ColorPalettes.black.withOpacity(.9),
                            ColorPalettes.black.withOpacity(.3),
                            ColorPalettes.black.withOpacity(.95)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.1, 0.5, 0.9]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CardDiscover(
                      image: movie.posterPath,
                      title: movie.title,
                      rating: movie.voteAverage,
                      genre: movie.genreIds,
                      onTap: () {
                        Modular.to.pushNamed(
                          './detail_movies',
                          arguments: ScreenArguments(
                            movies: movie,
                            isFromMovie: true,
                            isFromBanner: false,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Sizes.width(context) / 7,
                        right: Sizes.dp30(context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            '$position',
                            style: TextStyle(
                              color: ColorPalettes.white,
                              fontSize: Sizes.dp25(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '/${state.results.length}',
                            style: TextStyle(
                              color: ColorPalettes.white,
                              fontSize: Sizes.dp16(context),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
