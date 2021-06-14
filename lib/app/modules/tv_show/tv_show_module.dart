import 'package:flutter_modular/flutter_modular.dart';

import 'pages/airing_today/airing_today_screen.dart';
import 'pages/airing_today/bloc/tv_airing_today_bloc.dart';
import 'pages/on_the_air/bloc/tv_on_the_air_bloc.dart';
import 'pages/on_the_air/on_the_air_screen.dart';
import 'pages/popular/bloc/tv_popular_bloc.dart';
import 'pages/popular/tv_popular_screen.dart';
import 'tv_show_screen.dart';

class TvShowModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TvAiringTodayBloc(repository: i())),
    Bind.lazySingleton((i) => TvOnTheAirBloc(repository: i())),
    Bind.lazySingleton((i) => TvPopularBloc(repository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => TvShowScreen()),
    ChildRoute('/airing_today', child: (_, __) => AiringTodayScreen()),
    ChildRoute('/on_the_air', child: (_, __) => OnTheAirScreen()),
    ChildRoute('/tv_popular', child: (_, __) => TvPopularScreen()),
  ];
}
