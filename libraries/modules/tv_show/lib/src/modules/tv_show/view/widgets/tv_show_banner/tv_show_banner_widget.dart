import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/tv_show.dart';
import '../../../domain/errors/tv_show_failures.dart';
import 'tv_show_banner_store.dart';

class TvShowBanner extends StatefulWidget {
  const TvShowBanner({Key? key}) : super(key: key);

  @override
  State<TvShowBanner> createState() => _TvShowBannerState();
}

class _TvShowBannerState extends State<TvShowBanner> {
  final store = Modular.get<TvShowBannerStore>();
  int _current = 0;
  @override
  void initState() {
    super.initState();
    store.load();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<TvShowBannerStore, Failure, List<TvShow>>.transition(
      onError: (context, error) {
        return error is TvAiringTodayNoInternetConnection
            ? NoInternetWidget(
                message: AppConstant.noInternetConnection,
                onPressed: store.load,
              )
            : CustomErrorWidget(message: error?.errorMessage);
      },
      onLoading: (context) => const ShimmerBanner(),
      onState: (context, state) => StatefulBuilder(
        builder: (context, setState) => BannerHome(
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
          data: List.from(
            state.map(
              (movie) => ScreenData(
                movie.tvShowId,
                movie.title,
                movie.overview,
                movie.releaseDate,
                movie.genreIds,
                movie.voteAverage,
                movie.popularity,
                movie.posterPath,
                movie.backdropPath,
                movie.tvName,
                movie.tvRelease,
              ),
            ),
          ),
          currentIndex: _current,
          routeNameDetail: './detail_movies',
          routeNameAll: './on_the_air',
        ),
      ),
    );
  }
}
