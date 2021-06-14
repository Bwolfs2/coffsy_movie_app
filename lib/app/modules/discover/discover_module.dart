import 'package:flutter_modular/flutter_modular.dart';

import 'pages/bloc/discover_movie_bloc.dart';
import 'pages/discover_screen.dart';

class DiscoverModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DiscoverMovieBloc(repository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DiscoverScreen()),
  ];
}
