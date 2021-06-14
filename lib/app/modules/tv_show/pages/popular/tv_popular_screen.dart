import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/pages/on_the_air/bloc/tv_on_the_air_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'bloc/tv_popular_bloc.dart';
import 'bloc/tv_popular_event.dart';
import 'bloc/tv_popular_state.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

class TvPopularScreen extends StatefulWidget {
  @override
  _TvPopularScreenState createState() => _TvPopularScreenState();
}

class _TvPopularScreenState extends State<TvPopularScreen> {
  Completer<void> _refreshCompleter = Completer<void>();

  _loadTvPopular(BuildContext context) {
    Modular.get<TvPopularBloc>().add(LoadTvPopular());
  }

  Future<void> _refresh() {
    _loadTvPopular(context);
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    _loadTvPopular(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          bloc: Modular.get<TvPopularBloc>(),
          builder: (context, state) {
            if (state is TvPopularHasData) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return ListView.builder(
                itemCount: state.result.results.length,
                itemBuilder: (BuildContext context, int index) {
                  Movies movies = state.result.results[index];
                  return CardMovies(
                    image: movies.posterPath,
                    title: movies.tvName ?? 'No TV Name',
                    vote: movies.voteAverage.toString(),
                    releaseDate: movies.tvRelease ?? 'No TV Release',
                    overview: movies.overview,
                    genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
                    onTap: () {
                      Modular.to.pushNamed(
                        "/detail_movies",
                        arguments: ScreenArguments(movies, false, false),
                      );
                    },
                  );
                },
              );
            } else if (state is TvPopularLoading) {
              return ShimmerList();
            } else if (state is TvPopularError) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.errorMessage);
            } else if (state is TvPopularNoData) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.message);
            } else if (state is TvPopularNoInternetConnection) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () => _loadTvPopular(context),
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
