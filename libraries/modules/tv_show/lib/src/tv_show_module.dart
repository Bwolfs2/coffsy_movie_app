import 'package:flutter_modular/flutter_modular.dart';

import 'pages/airing_today/airing_today_page.dart';
import 'pages/airing_today/airing_today_store.dart';
import 'pages/on_the_air/on_the_air_page.dart';
import 'pages/on_the_air/on_the_air_store.dart';
import 'pages/popular/tv_popular_page.dart';
import 'pages/popular/tv_popular_store.dart';
import 'tv_show_page.dart';
import 'widgets/airing_today/airing_today_widget_store.dart';
import 'widgets/tv_show_banner/tv_show_banner_store.dart';
import 'widgets/tv_show_popular/tv_show_popular_store.dart';

class TvShowModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AiringTodayStore(
          i(),
        )),
    Bind.lazySingleton((i) => TvPopularStore(
          i(),
        )),
    Bind.lazySingleton((i) => TvShowPopularStore(
          i(),
        )),
    Bind.lazySingleton((i) => TvShowBannerStore(
          i(),
        )),
    Bind.lazySingleton((i) => OnTheAirStore(
          i(),
        )),
    Bind.lazySingleton((i) => AiringTodayWidgetStore(
          i(),
        )),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => TvShowPage(),
    ),
    ChildRoute(
      '/airing_today',
      child: (_, __) => AiringTodayPage(),
    ),
    ChildRoute(
      '/on_the_air',
      child: (_, __) => OnTheAirPage(),
    ),
    ChildRoute(
      '/tv_popular',
      child: (_, __) => TvPopularPage(),
    ),
  ];
}
