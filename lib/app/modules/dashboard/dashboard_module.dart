import 'package:coffsy_movie_app/app/modules/movie/movie_module.dart';
import 'package:coffsy_movie_app/app/modules/movie/pages/now_playing/now_playing_store.dart';

import 'package:coffsy_movie_app/app/modules/movie/pages/popular/movie_popular_store.dart';

import 'package:coffsy_movie_app/app/modules/movie/widgets/up_coming/up_coming_widget_store.dart';
import 'package:coffsy_movie_app/app/modules/tv_show/tv_show_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'dashboard_screen.dart';

class DashboardModule extends Module {
  @override
  final List<Bind> binds = [
    //Deu BO aqui
    Bind.lazySingleton((i) => MoviePlayingStore(i())),
    Bind.lazySingleton((i) => MoviePopularStore(i())),
    Bind.lazySingleton((i) => UpComingWidgetStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DashBoardScreen(), children: [
      ModuleRoute('/movie_module', module: MovieModule()),
      ModuleRoute('/tv_show', module: TvShowModule()),
    ]),
  ];
}
