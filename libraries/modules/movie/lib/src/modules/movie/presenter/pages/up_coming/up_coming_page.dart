import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/errors/movie_failures.dart';
import 'up_coming_store.dart';

class UpComingPage extends StatefulWidget {
  @override
  _UpComingPageState createState() => _UpComingPageState();
}

class _UpComingPageState extends State<UpComingPage> {
  final store = Modular.get<UpComingStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Up Coming Movie'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<UpComingStore, Failure, List<Movie>>.transition(
          store: store,
          onError: (context, error) {
            if (error is NoDataFound) {
              return const Center(child: Text('No Up Comming Movies Found'));
            }
            if (error is MovieUpComingNoInternetConnection) {
              return NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () async => await store.load(),
              );
            }
            return CustomErrorWidget(message: error?.errorMessage);
          },
          onLoading: (context) => ShimmerList(),
          onState: (context, state) => ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final movies = state[index];
              return CardMovies(
                image: movies.posterPath,
                title: movies.title,
                vote: movies.voteAverage.toString(),
                releaseDate: movies.releaseDate,
                overview: movies.overview,
                genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    './detail_movies',
                    arguments: ScreenArguments(
                      movies: Movies(
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
            },
          ),
        ),
      ),
    );
  }
}
