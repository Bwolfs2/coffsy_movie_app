import 'dart:async';

import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/pages/on_the_air/bloc/tv_on_the_air_bloc.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/pages/on_the_air/bloc/tv_on_the_air_event.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'bloc/tv_on_the_air_state.dart';

class OnTheAirScreen extends StatefulWidget {
  @override
  _OnTheAirScreenState createState() => _OnTheAirScreenState();
}

class _OnTheAirScreenState extends State<OnTheAirScreen> {
  Completer<void> _refreshCompleter = Completer<void>();

  _loadTvOnAir(BuildContext context) {
    Modular.get<TvOnTheAirBloc>().add(LoadTvOnTheAir());
  }

  Future<void> _refresh() {
    _loadTvOnAir(context);
    return _refreshCompleter.future;
  }

  @override
  void initState() {
    super.initState();
    _loadTvOnAir(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<TvOnTheAirBloc, TvOnTheAirState>(
          bloc: Modular.get<TvOnTheAirBloc>(),
          builder: (context, state) {
            if (state is TvOnTheAirHasData) {
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
            } else if (state is TvOnTheAirLoading) {
              return ShimmerList();
            } else if (state is TvOnTheAirError) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.errorMessage);
            } else if (state is TvOnTheAirNoData) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return CustomErrorWidget(message: state.message);
            } else if (state is TvOnTheAirNoInternetConnection) {
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: () => _loadTvOnAir(context),
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
