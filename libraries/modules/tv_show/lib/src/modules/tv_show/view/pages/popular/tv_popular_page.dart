import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/tv_popular_show.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'tv_popular_store.dart';

class TvPopularPage extends StatefulWidget {
  @override
  _TvPopularPageState createState() => _TvPopularPageState();
}

class _TvPopularPageState extends State<TvPopularPage> {
  final store = Modular.get<TvPopularStore>();

  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular'),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        onRefresh: store.load,
        showChildOpacityTransition: false,
        child: ScopedBuilder<TvPopularStore, Failure, List<TvPopularShow>>.transition(
          onError: (context, error) {
            if (error is NoDataFound) {
              return const Center(child: Text('No Trailers Found'));
            }

            if (error is TvShowPopularNoInternetConnection) {
              return Center(
                child: NoInternetWidget(
                  message: AppConstant.noInternetConnection,
                  onPressed: () async => await store.load(),
                ),
              );
            }

            return CustomErrorWidget(message: error?.errorMessage);
          },
          onLoading: (context) => const ShimmerList(),
          onState: (context, state) => ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final tvPopularShow = state[index];
              return CardMovies(
                image: tvPopularShow.posterPath,
                title: tvPopularShow.tvName ?? 'No TV Name',
                vote: tvPopularShow.voteAverage.toString(),
                releaseDate: tvPopularShow.tvRelease ?? 'No TV Release',
                overview: tvPopularShow.overview,
                genre: tvPopularShow.genreIds.take(3).map(buildGenreChip).toList(),
                onTap: () {
                  Modular.to.pushNamed(
                    './detail_movies',
                    arguments: ScreenArguments(
                      movies: Movies(
                        tvPopularShow.id,
                        tvPopularShow.title,
                        tvPopularShow.overview,
                        tvPopularShow.releaseDate,
                        tvPopularShow.genreIds,
                        tvPopularShow.voteAverage,
                        tvPopularShow.popularity,
                        tvPopularShow.posterPath,
                        tvPopularShow.backdropPath,
                        tvPopularShow.tvName,
                        tvPopularShow.tvRelease,
                      ),
                      isFromBanner: false,
                    ),
                    forRoot: true,
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
