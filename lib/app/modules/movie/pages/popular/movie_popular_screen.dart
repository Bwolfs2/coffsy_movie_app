import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'bloc/movie_popular_bloc.dart';
import 'bloc/movie_popular_event.dart';
import 'bloc/movie_popular_state.dart';

class MoviePopularScreen extends StatefulWidget {
  @override
  _MoviePopularScreenState createState() => _MoviePopularScreenState();
}

class _MoviePopularScreenState extends State<MoviePopularScreen> {
  Completer<void> _refreshCompleter = Completer<void>();

  _loadMoviePopular(BuildContext context) {
    Modular.get<MoviePopularBloc>().add(LoadMoviePopular());
  }

  @override
  void initState() {
    super.initState();
    _loadMoviePopular(context);
  }

  Future<void> _refresh() {
    _loadMoviePopular(context);
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          bloc: Modular.get<MoviePopularBloc>(),
          builder: (context, state) {
            if (state is MoviePopularHasData) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return ListView.builder(
                itemCount: state.result.results.length,
                itemBuilder: (BuildContext context, int index) {
                  Movies movies = state.result.results[index];
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
              );
            } else if (state is MoviePopularLoading) {
              return ShimmerList();
            } else if (state is MoviePopularError) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.errorMessage);
            } else if (state is MoviePopularNoData) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.message);
            } else if (state is MoviePopularNoInternetConnection) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () => _loadMoviePopular(context),
              );
            } else {
              return Center(child: Text(""));
            }
          },
        ),
      ),
    );
  }
}
