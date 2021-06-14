import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/pages/on_the_air/bloc/tv_on_the_air_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'bloc/tv_airing_today_bloc.dart';
import 'bloc/tv_airing_today_event.dart';
import 'bloc/tv_airing_today_state.dart';

class AiringTodayScreen extends StatefulWidget {
  @override
  _AiringTodayScreenState createState() => _AiringTodayScreenState();
}

class _AiringTodayScreenState extends State<AiringTodayScreen> {
  Completer<void> _refreshCompleter = Completer<void>();

  _loadTvAiring(BuildContext context) {
    Modular.get<TvAiringTodayBloc>().add(LoadTvAiringToday());
  }

  Future<void> _refresh() {
    _loadTvAiring(context);
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    _loadTvAiring(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<TvAiringTodayBloc, TvAiringTodayState>(
          bloc: Modular.get<TvAiringTodayBloc>(),
          builder: (context, state) {
            if (state is TvAiringTodayHasData) {
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
            } else if (state is TvAiringTodayLoading) {
              return ShimmerList();
            } else if (state is TvAiringTodayError) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.errorMessage);
            } else if (state is TvAiringTodayNoData) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.message);
            } else if (state is TvAiringTodayNoInternetConnection) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () => _loadTvAiring(context),
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
