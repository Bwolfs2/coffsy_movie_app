import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/errors/movie_failures.dart';
import 'up_coming_widget_store.dart';

class UpComingWidget extends StatefulWidget {
  const UpComingWidget({Key? key}) : super(key: key);

  @override
  _UpComingWidgetState createState() => _UpComingWidgetState();
}

class _UpComingWidgetState extends State<UpComingWidget> {
  final store = Modular.get<UpComingWidgetStore>();
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Up Coming',
                style: TextStyle(
                  fontSize: Sizes.dp14(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.dp16(context),
                ),
                onPressed: () {
                  Modular.to.pushNamed('./up_coming', forRoot: true);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: ScopedBuilder<UpComingWidgetStore, Failure, List<Movie>>.transition(
            onError: (context, error) {
              if (error is MovieNowPlayingNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () async => await store.load(),
                );
              }
              return CustomErrorWidget(message: error?.errorMessage);
            },
            onLoading: (context) => const ShimmerCard(),
            onState: (context, state) => state.isEmpty
                ? const SizedBox.shrink()
                : ListView.builder(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.length > 5 ? 5 : state.length,
                    itemBuilder: (context, index) {
                      final movies = state[index];
                      return CardHome(
                        image: movies.posterPath,
                        title: movies.title,
                        rating: movies.voteAverage,
                        onTap: () {
                          Modular.to.pushNamed(
                            './detail_movies',
                            arguments: ScreenArguments(
                              screenData: ScreenData(
                                movies.id,
                                movies.title,
                                movies.overview,
                                movies.releaseDate,
                                movies.genreIds,
                                movies.voteAverage,
                                movies.popularity,
                                movies.posterPath,
                                movies.backdropPath,
                                movies.tvName,
                                movies.tvRelease,
                              ),
                              isFromMovie: true,
                              isFromBanner: false,
                            ),
                            forRoot: true,
                          );
                        },
                      );
                    }),
          ),
        ),
      ],
    );
  }
}
