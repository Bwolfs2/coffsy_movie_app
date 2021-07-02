import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'airing_today_store.dart';

class AiringTodayPage extends StatefulWidget {
  @override
  _AiringTodayPageState createState() => _AiringTodayPageState();
}

class _AiringTodayPageState extends State<AiringTodayPage> {
  final store = Modular.get<AiringTodayStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<AiringTodayStore, Failure, List<Movie>>(
          store: store,
          onError: (context, error) {
            if (error is NoDataFound) {
              return Center(child: Text('No Airing Today Found'));
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
            itemCount: state.length,
            itemBuilder: (context, index) {
              final movie = state[index];
              return CardMovies(
                image: movie.posterPath,
                title: movie.tvName ?? 'No TV Name',
                vote: movie.voteAverage.toString(),
                releaseDate: movie.tvRelease ?? 'No TV Release',
                overview: movie.overview,
                genre: movie.genreIds.take(3).map(buildGenreChip).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    './detail',
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
                      isFromBanner: false,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
