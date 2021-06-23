import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'movie_banner_store.dart';

class MovieBanners extends StatefulWidget {
  const MovieBanners({Key? key}) : super(key: key);

  @override
  _MovieBannersState createState() => _MovieBannersState();
}

class _MovieBannersState extends State<MovieBanners> {
  final store = Modular.get<MovieBannerStore>();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<MovieBannerStore, Failure, Result>(
      store: store,
      onError: (context, error) => CustomErrorWidget(message: error?.errorMessage),
      onLoading: (context) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      onState: (context, state) => state is EmptyResult
          ? const SizedBox.shrink()
          : StatefulBuilder(
              builder: (context, setState) => BannerHome(
                isFromMovie: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                data: state,
                currentIndex: _current,
                routeNameDetail: '/detail_movies',
                routeNameAll: '/dashboard/movie_module/now_playing',
              ),
            ),
    );
  }
}
