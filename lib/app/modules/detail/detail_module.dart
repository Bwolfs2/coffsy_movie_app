import 'package:coffsy_movie_app/app/modules/detail/pages/detail_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/bloc/crew/crew_bloc.dart';
import 'pages/bloc/trailer/trailer_bloc.dart';

class DetailModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TrailerBloc(repository: i())),
    Bind.lazySingleton((i) => CrewBloc(repository: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DetailPage(arguments: args.data)),
  ];
}
