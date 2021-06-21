import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../errors/airing_today_failures.dart';
import 'tv_popular_store.dart';

class TvPopularScreen extends StatefulWidget {
  @override
  _TvPopularScreenState createState() => _TvPopularScreenState();
}

class _TvPopularScreenState extends State<TvPopularScreen> {
  final store = Modular.get<TvPopularStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<TvPopularStore, Failure, Result>(
          store: store,
          onError: (context, error) => error is TvShowPopularNoInternetConnection
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
                title: movies.tvName ?? 'No TV Name',
                vote: movies.voteAverage.toString(),
                releaseDate: movies.tvRelease ?? 'No TV Release',
                overview: movies.overview,
                genre: movies.genreIds.take(3).map(buildGenreChip).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    '/detail_movies',
                    arguments: ScreenArguments(
                      movies: movies,
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
