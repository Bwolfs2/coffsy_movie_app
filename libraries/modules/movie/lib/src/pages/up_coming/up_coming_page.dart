import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'errors/movie_up_coming_failures.dart';
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
        title: Text('Up Coming Movie'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<UpComingStore, Failure, Result>(
          store: store,
          onError: (context, error) => error is MovieUpComingNoInternetConnection
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
            itemBuilder: (context, index) {
              final movies = state.results[index];
              return CardMovies(
                image: movies.posterPath,
                title: movies.title,
                vote: movies.voteAverage.toString(),
                releaseDate: movies.releaseDate,
                overview: movies.overview,
                genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    '/detail_movies',
                    arguments: ScreenArguments(
                      movies: movies,
                      isFromMovie: true,
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
