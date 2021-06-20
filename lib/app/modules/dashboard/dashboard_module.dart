import 'package:flutter_modular/flutter_modular.dart';

import '../movie/movie_module.dart';
import '../movie/pages/now_playing/now_playing_store.dart';
import '../movie/pages/popular/movie_popular_store.dart';
import '../movie/widgets/up_coming/up_coming_widget_store.dart';
import '../tv_show/tv_show_module.dart';
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
