import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'airing_today_widget_store.dart';

class AiringTodayWidget extends StatefulWidget {
  const AiringTodayWidget({Key? key}) : super(key: key);

  @override
  _AiringTodayWidgetState createState() => _AiringTodayWidgetState();
}

class _AiringTodayWidgetState extends State<AiringTodayWidget> {
  final store = Modular.get<AiringTodayWidgetStore>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Text(
                'Airing Today',
                style: TextStyle(
                  fontSize: Sizes.dp14(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.dp16(context),
                ),
                onPressed: () {
                  Modular.to.pushNamed('./airing_today', forRoot: true);
                },
              ),
            ],
          ),
        ),
        Container(
          width: Sizes.width(context),
          height: Sizes.width(context) / 1.8,
          child: ScopedBuilder<AiringTodayWidgetStore, Failure, List<Movie>>(
            store: store,
            onError: (context, error) {
              if (error is NoDataFound) {
                return Center(child: Text('No Trailers Found'));
              }

              if (error is TvAiringTodayNoInternetConnection) {
                return NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () async => await store.load(),
                );
              }
              return CustomErrorWidget(message: error?.errorMessage);
            },
            onLoading: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            onState: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.length > 5 ? 5 : state.length,
              itemBuilder: (context, index) {
                final movie = state[index];
                return CardHome(
                  image: movie.posterPath,
                  title: movie.tvName ?? 'No TV Name',
                  rating: movie.voteAverage,
                  onTap: () {
                    Modular.to.pushNamed(
                      '/detail_movies',
                      arguments: ScreenArguments(
                          movies: Movies(
                            movie.id,
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
                          isFromMovie: false,
                          isFromBanner: false),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
