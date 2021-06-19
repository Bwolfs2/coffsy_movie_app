import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'errors/movie_popular_failures.dart';
import 'movie_popular_store.dart';

class MoviePopularScreen extends StatefulWidget {
  @override
  _MoviePopularScreenState createState() => _MoviePopularScreenState();
}

class _MoviePopularScreenState extends State<MoviePopularScreen> {
  var store = Modular.get<MoviePopularStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<MoviePopularStore, Failure, Result>(
            store: store,
            onError: (context, error) => error is MoviePopularNoInternetConnection
                ? NoInternetWidget(
                    message: AppConstant.noInternetConnection,
                    onPressed: () async => await store.load(),
                  )
                : CustomErrorWidget(message: error?.errorMessage),
            onLoading: (context) => Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
            onState: (context, state) => ListView.builder(
                  itemCount: state.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    Movies movies = state.results[index];
                    return CardMovies(
                      image: movies.posterPath,
                      title: movies.title,
                      vote: movies.voteAverage.toString(),
                      releaseDate: movies.releaseDate,
                      overview: movies.overview,
                      genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
                      onTap: () {
                        Modular.to.pushNamed(
                          "/detail_movies",
                          arguments: ScreenArguments(movies, true, false),
                        );
                      },
                    );
                  },
                )),
      ),
    );
  }
}
