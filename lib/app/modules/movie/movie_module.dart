import 'package:flutter_modular/flutter_modular.dart';

import 'movie_screen.dart';
import 'pages/now_playing/now_playing_screen.dart';
import 'pages/now_playing/now_playing_store.dart';
import 'pages/popular/movie_popular_screen.dart';
import 'pages/popular/movie_popular_store.dart';
import 'pages/up_coming/up_coming_screen.dart';
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
    ChildRoute('/', child: (_, args) => MovieScreen()),
    ChildRoute('/now_playing', child: (_, __) => NowPlayingScreen()),
    ChildRoute('/movie_popular', child: (_, __) => MoviePopularScreen()),
    ChildRoute('/up_coming', child: (_, __) => UpComingScreen()),
  ];
}
