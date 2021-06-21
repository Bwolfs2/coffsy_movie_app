import 'package:flutter_modular/flutter_modular.dart';
import 'package:tv_show/tv_show.dart';
import 'package:movie/movie.dart';
import 'dashboard_page.dart';

class DashboardModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DashBoardPage(), children: [
      ModuleRoute('/movie_module', module: MovieModule()),
      ModuleRoute('/tv_show', module: TvShowModule()),
    ]),
  ];
}
