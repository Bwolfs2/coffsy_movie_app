import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/errors/airing_today_failures.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'tv_show_banner_store.dart';

class TvShowBanner extends StatefulWidget {
  const TvShowBanner({Key? key}) : super(key: key);

  @override
  _TvShowBannerState createState() => _TvShowBannerState();
}

class _TvShowBannerState extends State<TvShowBanner> {
  var store = Modular.get<TvShowBannerStore>();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<TvShowBannerStore, Failure, Result>(
      store: store,
      onError: (context, error) => error is TvShowBannerNoInternetConnection
          ? NoInternetWidget(
              message: AppConstant.noInternetConnection,
              onPressed: () async => await store.load(),
            )
          : CustomErrorWidget(message: error?.errorMessage),
      onLoading: (context) => Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onState: (context, state) => StatefulBuilder(
        builder: (context, setState) => BannerHome(
          isFromMovie: false,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
          data: state,
          currentIndex: _current,
          routeNameDetail: "/detail_movies",
          routeNameAll: '/dashboard/tv_show/on_the_air',
        ),
      ),
    );
  }
}
