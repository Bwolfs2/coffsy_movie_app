import 'package:coffsy_movie_app/app/modules/movie/movie_module.dart';
import 'package:coffsy_movie_app/app/modules/movie/pages/now_playing/bloc/movie_now_playing_bloc.dart';
import 'package:coffsy_movie_app/app/modules/movie/pages/popular/bloc/movie_popular_bloc.dart';
import 'package:coffsy_movie_app/app/modules/movie/pages/up_coming/bloc/movie_up_coming_bloc.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/tv_show_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dashboard_screen.dart';

class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    //Deu BO aqui
    Bind.lazySingleton((i) => MovieNowPlayingBloc(repository: i())),
    Bind.lazySingleton((i) => MoviePopularBloc(repository: i())),
    Bind.lazySingleton((i) => MovieUpComingBloc(repository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DashBoardScreen(), children: [
      ModuleRoute('/movie_module', module: MovieModule()),
      ModuleRoute('/tv_show', module: TvShowModule()),
    ]),
  ];
}
