import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/errors/airing_today_failures.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'on_the_air_store.dart';

class OnTheAirScreen extends StatefulWidget {
  @override
  _OnTheAirScreenState createState() => _OnTheAirScreenState();
}

class _OnTheAirScreenState extends State<OnTheAirScreen> {
  var store = Modular.get<OnTheAirStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<OnTheAirStore, Failure, Result>(
          store: store,
          onError: (context, error) => error is OnTheAirNoInternetConnection
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
          ),
        ),
      ),
    );
  }
}
