import 'package:flutter_modular/flutter_modular.dart';

import 'movie_screen.dart';
import 'pages/now_playing/bloc/movie_now_playing_bloc.dart';
import 'pages/now_playing/now_playing_screen.dart';
import 'pages/popular/bloc/movie_popular_bloc.dart';
import 'pages/popular/movie_popular_screen.dart';
import 'pages/up_coming/bloc/movie_up_coming_bloc.dart';
import 'pages/up_coming/up_coming_screen.dart';

class MovieModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MovieNowPlayingBloc(repository: i())),
    Bind.lazySingleton((i) => MoviePopularBloc(repository: i())),
    Bind.lazySingleton((i) => MovieUpComingBloc(repository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MovieScreen()),
    ChildRoute('/now_playing', child: (_, __) => NowPlayingScreen()),
    ChildRoute('/movie_popular', child: (_, __) => MoviePopularScreen()),
    ChildRoute('/up_coming', child: (_, __) => UpComingScreen()),
  ];
}
