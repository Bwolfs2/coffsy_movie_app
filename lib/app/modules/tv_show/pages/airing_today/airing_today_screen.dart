import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../errors/airing_today_failures.dart';
import 'airing_today_store.dart';

class AiringTodayScreen extends StatefulWidget {
  @override
  _AiringTodayScreenState createState() => _AiringTodayScreenState();
}

class _AiringTodayScreenState extends State<AiringTodayScreen> {
  final store = Modular.get<AiringTodayStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<AiringTodayStore, Failure, Result>(
          store: store,
          onError: (context, error) => error is TvAiringTodayNoInternetConnection
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
