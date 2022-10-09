import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/errors/movie_failures.dart';
import 'movie_popular_store.dart';

class MoviePopularPage extends StatefulWidget {
  const MoviePopularPage({super.key});

  @override
  State<MoviePopularPage> createState() => _MoviePopularPageState();
}

class _MoviePopularPageState extends State<MoviePopularPage> {
  final store = Modular.get<MoviePopularStore>();

  @override
  void initState() {
    super.initState();
    //   store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<MoviePopularStore, Failure, List<Movie>>.transition(
          store: store,
          onError: (context, error) {
            if (error is NoDataFound) {
              return const Center(child: Text('No Popular Movies Found'));
            }
            if (error is MoviePopularNoInternetConnection) {
              return Center(
                child: NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: store.load,
                ),
              );
            }
            return CustomErrorWidget(message: error?.errorMessage);
          },
          onLoading: (context) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
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
                genre: movies.genreIds.take(3).map((id) => GenreChip(id: id)).toList(),
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
