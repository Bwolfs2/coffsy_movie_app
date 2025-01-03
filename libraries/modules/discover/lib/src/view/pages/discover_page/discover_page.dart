import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/errors/discover_failures.dart';
import 'discover_store.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final store = Modular.get<DiscoverStore>();

  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: ColorPalettes.black,
      floatingActionButton: FloatingActionButton(
        tooltip: 'backAbout',
        onPressed: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: ColorPalettes.white,
        ),
      ),
      body: ScopedBuilder<DiscoverStore, Failure, List<Movie>>.transition(
        onError: (context, error) {
          return error is DiscoverMovieNoInternetConnection
              ? NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: store.load,
                )
              : CustomErrorWidget(message: error?.errorMessage);
        },
        onLoading: (context) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        onState: (context, state) {
          return PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.length,
            itemBuilder: (context, index) {
              final movie = state[index];
              final position = index + 1;

              return SizedBox(
                width: width,
                height: height,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: movie.backdropPath.imageOriginal,
                      width: width,
                      height: MediaQuery.sizeOf(context).height,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const ErrorImage(),
                    ),
                    Container(
                      color: ColorPalettes.grey.withAlpha(153),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorPalettes.black.withAlpha(230),
                            ColorPalettes.black.withAlpha(77),
                            ColorPalettes.black.withAlpha(242),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.1, 0.5, 0.9],
                        ),
                      ),
                    ),
                    Align(
                      child: CardDiscover(
                        image: movie.posterPath,
                        title: movie.title,
                        rating: movie.voteAverage,
                        genre: movie.genreIds,
                        onTap: () {
                          Modular.to.pushNamed(
                            './detail_movies',
                            arguments: ScreenArguments(
                              screenData: ScreenData(
                                movie.movieId,
                                movie.title,
                                movie.overview,
                                movie.releaseDate,
                                movie.genreIds,
                                movie.voteAverage,
                                movie.popularity,
                                movie.posterPath,
                                movie.backdropPath,
                                movie.tvName,
                                movie.tvRelease,
                              ),
                              isFromMovie: true,
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
                          top: MediaQuery.sizeOf(context).width / 7,
                          right: 30,
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
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '/${state.length}',
                              style: TextStyle(
                                color: ColorPalettes.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
