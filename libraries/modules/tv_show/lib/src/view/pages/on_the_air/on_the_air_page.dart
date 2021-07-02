import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/on_the_air.dart';
import '../../../domain/errors/airing_today_failures.dart';
import 'on_the_air_store.dart';

class OnTheAirPage extends StatefulWidget {
  @override
  _OnTheAirPageState createState() => _OnTheAirPageState();
}

class _OnTheAirPageState extends State<OnTheAirPage> {
  final store = Modular.get<OnTheAirStore>();

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
        child: ScopedBuilder<OnTheAirStore, Failure, List<OnTheAir>>(
          store: store,
          onError: (context, error) => error is TvOnTheAirNoInternetConnection
              ? NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () async => await store.load(),
                )
              : CustomErrorWidget(message: error?.errorMessage),
          onLoading: (context) => Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          onState: (context, state) => ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final onTheAir = state[index];
              return CardMovies(
                image: onTheAir.posterPath,
                title: onTheAir.tvName ?? 'No TV Name',
                vote: onTheAir.voteAverage.toString(),
                releaseDate: onTheAir.tvRelease ?? 'No TV Release',
                overview: onTheAir.overview,
                genre: onTheAir.genreIds.take(3).map(buildGenreChip).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    './detail',
                    arguments: ScreenArguments(
                      movies: Movies(
                        onTheAir.id,
                        onTheAir.title,
                        onTheAir.overview,
                        onTheAir.releaseDate,
                        onTheAir.genreIds,
                        onTheAir.voteAverage,
                        onTheAir.popularity,
                        onTheAir.posterPath,
                        onTheAir.backdropPath,
                        onTheAir.tvName,
                        onTheAir.tvRelease,
                      ),
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
