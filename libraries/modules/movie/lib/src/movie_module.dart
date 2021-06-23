import 'package:flutter_modular/flutter_modular.dart';

import 'movie_page.dart';
import 'pages/now_playing/now_playing_page.dart';
import 'pages/now_playing/now_playing_store.dart';
import 'pages/popular/movie_popular_page.dart';
import 'pages/popular/movie_popular_store.dart';
import 'pages/up_coming/up_coming_page.dart';
import 'pages/up_coming/up_coming_store.dart';
import 'widgets/movie_banner/movie_banner_store.dart';
import 'widgets/popular/popular_store.dart';
import 'widgets/up_coming/up_coming_widget_store.dart';

class MovieModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MoviePlayingStore(i())),
    Bind.lazySingleton((i) => MoviePopularStore(i())),
    Bind.lazySingleton((i) => UpComingWidgetStore(i())),
    //

    Bind.lazySingleton((i) => MoviePlayingStore(i())),
    Bind.lazySingleton((i) => UpComingWidgetStore(i())),
    Bind.lazySingleton((i) => UpComingStore(i())),
    Bind.lazySingleton((i) => PopularStore(i())),
    Bind.lazySingleton((i) => MovieBannerStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MoviePage()),
    ChildRoute('/now_playing', child: (_, __) => NowPlayingPage()),
    ChildRoute('/movie_popular', child: (_, __) => MoviePopularPage()),
    ChildRoute('/up_coming', child: (_, __) => UpComingPage()),
  ];
}
